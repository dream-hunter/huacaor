class User
  include Mongoid::Document
  field :email, :type => String
  field :password_hash, :type => String
  field :password_salt, :type => String
  field :name, :type => String
  field :username, :type => String
  field :douban_name, :type => String
  field :sina_name, :type => String
  field :desc, :type => String

  attr_accessor :password
  before_save :encrypt_password
  #validates_presence_of :password, :on => :create
  #validates_presence_of :email
  #validates_uniqueness_of :email

  validates :password, :presence => true, :on => :create
  validates :email, :presence => true
  validates :email, :uniqueness => true

  validates :name, :presence => {:message => "请输入名字"}
  validates :name, :uniqueness => true
  validates :username, :uniqueness => {:message => "此自定义URL已存在，请重新输入", :unless => "username.blank?"}

  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end

  def self.authenticate(email, password)  
    user = self.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
      user  
    else  
      nil  
    end  
  end  
  
  
end
