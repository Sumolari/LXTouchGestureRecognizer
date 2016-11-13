Pod::Spec.new do |s|

  s.name         = "LXTouchGestureRecognizer"
  s.version      = "0.0.1"
  s.summary      = "Continuous touch gesture recognizer."

  s.description  = <<-DESC
  A continuous touch gesture recognizer to allow highlighting views using a
  gesture-based approach instead of overriding touch methods, as detailed in
  http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer/.
                   DESC

  s.homepage     = "http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer/"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.authors = "Stan Chang Khin Boon", "Lluís Ulzurrun de Asanza i Sàez"

  s.source = {
  	:git => "https://github.com/Sumolari/LXTouchGestureRecognizer.git",
  	:tag => "#{s.version}"
  }

  s.source_files  = "Source", "source/**/*.{h,m}"

end
