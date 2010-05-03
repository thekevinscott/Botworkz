# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_botworkz_session',
  :secret      => 'ce7722737a29ebe95f0772560b4b40bb9b19c3b7067c42dad965d659b844865d80db4a7ff9826485da985d59eb2acd83af9725abbc8b051899110d19fd69aba2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
