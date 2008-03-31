require 'digest/sha1'
class Member < ActiveRecord::Base
  has_many :timetracks, :order => 'date ASC, created_at ASC' do
    def weeks
      timetracks = self.find(:all)
      return [] if timetracks.empty?
      first_week = timetracks.first.date.cweek
      last_week = timetracks.last.date.cweek
      first_week..last_week
    end
    
    def weeks_which_are_not_empty
      weeks.to_a.select { |week| in_week(week).empty? == false }
    end
    
    def in_week(week)
      self.find(:all, :conditions => ['date BETWEEN ? AND ?', Date.commercial(2008, week, 1), Date.commercial(2008, week, 7) ])
    end
    
    def total_hours_in_week(week)
      total=0
      arr = self.find(:all, :conditions => ['date BETWEEN ? AND ?', Date.commercial(2008, week, 1), Date.commercial(2008, week, 7) ])
      arr.each {|w| total += w.hours_spent }
      total
    end
  end
    
  belongs_to :group
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email, :group_id, :fullname
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  def total_hours
    timetracks.sum('hours_spent')
  end
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end

    
end
