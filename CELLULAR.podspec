Pod::Spec.new do |spec|
    spec.version       = '5.0.1'
    spec.swift_version = '5.0'
    spec.module_name   = 'CELLULAR'
    spec.name          = 'CELLULAR'
    spec.summary       = 'Collection of µ-frameworks and utility classes/extensions used in CELLULAR projects.'
    spec.homepage      = 'https://www.cellular.de'
    spec.authors       = { 'CELLULAR GmbH' => 'iosdev@cellular.de' }
    spec.license       = { :type => 'MIT', :file => 'LICENSE' }
    spec.source        = { :git => 'https://github.com/cellular/cellular-swift.git', :tag => spec.version.to_s }

    # Deployment Targets
    spec.ios.deployment_target     = '9.0'
    spec.tvos.deployment_target    = '9.0'
    spec.watchos.deployment_target = '2.0'

    # Subspecs

    spec.subspec 'Codable' do |sub|
        sub.source_files = 'Sources/Codable/**/*.swift'
    end

    spec.subspec 'Locking' do |sub|
        sub.source_files = 'Sources/Locking/**/*.swift'
    end

    spec.subspec 'Storyboard' do |sub|
        sub.source_files = 'Sources/Storyboard/**/*.swift'
    end

    # Default

    spec.default_subspecs = 'Result', 'Locking', 'Codable', 'Storyboard'
end
