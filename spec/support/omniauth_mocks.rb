module OmniauthMocks
  def google_mock
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: 'google',
      uid: '123456',
      info: {
        name: 'mock user',
        email: 'mock@example.com'
      }
    })
  end
end
