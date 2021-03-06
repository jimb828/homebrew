require 'formula'

class Elinks < Formula
  homepage 'http://elinks.or.cz/'
  url 'http://elinks.or.cz/download/elinks-0.11.7.tar.bz2'
  md5 'fcd087a6d2415cd4c6fd1db53dceb646'

  head 'http://elinks.cz/elinks.git'

  devel do
    version '0.12pre5'
    url 'http://elinks.cz/download/elinks-0.12pre5.tar.bz2'
    md5 '92790144290131ac5e63b44548b45e08'
  end

  if ARGV.build_head? and MacOS.xcode_version >= "4.3"
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  fails_with :llvm do
    build 2326
  end

  # enables 256 colors, per the manual
  def patches
    DATA
  end

  def install
    ENV.deparallelize
    ENV.delete('LD')
    system "./autogen.sh" if ARGV.build_head?
    system "./configure", "--prefix=#{prefix}", "--without-spidermonkey"
    system "make install"
  end
end

__END__
diff --git a/features.conf b/features.conf
index 1c0095c..7ee8b0d 100644
--- a/features.conf
+++ b/features.conf
@@ -501,7 +501,7 @@ CONFIG_88_COLORS=no
 #
 # Default: disabled
 
-CONFIG_256_COLORS=no
+CONFIG_256_COLORS=yes
 
 
 ### Ex-mode Interface

