class User
	include DataMapper::Resource
	include DataMapper::Validate
	
	attr_accessor :password
	
	property :id,				Serial
	property :email,			String
	property :crypted_password,	String
	property :created_on, 		Date
	property :last_song_at, 	Date, :default => lambda { |r,p| Date.today - 1 }
	
	has n, :songs, :through => :user_songs
	has n, :albums, :through => :user_albums
	
	validates_presence_of	:email
	validates_presence_of	:password, :if => :password_required
	validates_format_of		:email,	:with => :email_address
	validates_uniqueness_of    :email,    :case_sensitive => false
	
	
	before :save, :encrypt_password
	
	def self.authenticate(email, password)
		user = first(:conditions => ["lower(email) = lower(?)", email]) if email.present?
		user && user.has_password?(password) ? user : nil
	end

	def has_password?(password)
		::BCrypt::Password.new(crypted_password) == password
	end
	
	private

	def password_required
		crypted_password.blank?
	end

	def encrypt_password
		self.crypted_password = ::BCrypt::Password.create(password) if password.present?
	end
end
	