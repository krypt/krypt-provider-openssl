=begin

= Info

krypt-provider-openssl - Implementation using OpenSSL

Copyright (C) 2011-2013
Hiroshi Nakamura <nahi@ruby-lang.org>
Martin Bosslet <martin.bosslet@gmail.com>
All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=end

require 'ffi'

module Krypt
  module Provider

    class OpenSSL < Krypt::FFI::Provider

      def initialize
        super(Handle.krypt_ossl_get_provider)
      end

      module Handle
        extend ::FFI::Library
  
        # We cannot require the C extension in JRuby by default
        if RUBY_PLATFORM =~ /java/
          ffi_lib File.expand_path('../../kryptprovideropenssl.so', File.dirname(__FILE__))
        else
          require'kryptprovideropenssl.so'
          ffi_lib ::FFI::CURRENT_PROCESS
        end

        attach_function :krypt_ossl_get_provider, [], :pointer
      end
    end

  end
end

