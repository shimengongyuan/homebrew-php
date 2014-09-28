require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Swoole < AbstractPhp56Extension
  init
  homepage 'https://github.com/matyhtf/swoole'
  url 'http://pecl.php.net/get/swoole-1.7.5.tgz'
  sha1 '3ff5e0e8d0ae980e33136360c5112aaa52b1a56e'
  head 'https://github.com/matyhtf/swoole.git'

  def install
    Dir.chdir "swoole-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
