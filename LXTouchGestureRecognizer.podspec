Pod::Spec.new do |s|

  s.name         = "LXTouchGestureRecognizer"
  s.version      = "0.0.2"
  s.summary      = "Continuous touch gesture recognizer."

  s.description  = <<-DESC
  A continuous touch gesture recognizer to allow highlighting views using a
  gesture-based approach instead of overriding touch methods, as detailed in
  http://lxcid.com/2015/01/01/highlight-with-gesture-recognizer/.
                   DESC

  s.homepage     = "https://github.com/Sumolari/LXTouchGestureRecognizer.git"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios

  s.authors = "Stan Chang Khin Boon", "Lluís Ulzurrun de Asanza i Sàez"

  s.source = {
  	:git => "https://github.com/Sumolari/LXTouchGestureRecognizer.git",
  	:tag => "#{s.version}"
  }

  s.source_files  = "Source", "source/**/*.{h,m}"

end
