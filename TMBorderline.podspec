Pod::Spec.new do |s|
  s.name         = "TMBorderline"
  s.version      = "1.1"
  s.summary      = "borderline"
  s.description  = <<-DESC
                    borderline for UIView
                   DESC

  s.homepage     = "https://github.com/tangshimi/TMBorderline"
  s.license      = { :type => 'Copyright',
      :text => <<-LICENSE
      Copyright 2015 tangshimi. All rights reserved.
      LICENSE
  }
  s.author    = "tangshimi"
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/tangshimi/TMBorderline.git",:tag => "1.1" }


  s.source_files  = "TMBorderline/TMBorderline/*.{h,m}"
  s.requires_arc = true

end
