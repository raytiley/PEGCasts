# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pegcasts_session',
  :secret      => '8cc54cddf2beb94e50a9d01822e1eb0b46d086bf57085680d3d8b7496ae2428ec3f8524cf10b6202480b71622a51db5abfa17f409d74b1fc62e1c7b228334626'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
