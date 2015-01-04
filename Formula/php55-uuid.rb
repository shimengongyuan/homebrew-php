require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Uuid < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/uuid'
  url 'http://pecl.php.net/get/uuid-1.0.3.tgz'
  sha1 'f51820a310ade0eb7200375486bf88d721d89f17'
  head 'https://svn.php.net/repository/pecl/uuid/trunk'

  stable do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/4ad7ebf2bff53887f64ac5be802b85ea5856fa85/php-uuid.patch"
      sha1 "274dfb222ee214a876b2e5bd070b711ce79fd859"
    end
  end

  head do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/e802b0e6daebb4403dc77c81e149c5f8c8f49b7e/php-uuid-trunk.patch"
      sha1 "b5fbab7574cf035d318fd932ea5bd4bca0aa44e9"
    end
  end

  def install
    Dir.chdir "uuid-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uuid.so"
    write_config_file if build.with? "config-file"
  end
end
