Pod::Spec.new do |spec|
  spec.name         = "VTProLib"
  spec.version      = "0.0.1"
  spec.summary      = "Framework for viatom's device that CheckmePro."
  spec.description  = <<-DESC
			You can use Bluetooth to get various data on the peripherals you want through the Lib.
                   DESC
  spec.homepage     = "https://github.com/viatom-dev/VTProLib"
  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author    = "yangweichao"
  spec.platform     = :ios, "8.0"
  spec.source_files = "VTProLib/**/*,{h,m}"
  spec.source       = { :git => "https://github.com/viatom-dev/VTProLib.git", :tag => "0.0.1" }
  spec.framework  = "VTProLib.framework"
  spec.requires_arc = true
  spec.frameworks = "CoreBluetooth", "Foundation"
  spec.resource = "VTProLib/VTProLibBundle.bundle"
end
