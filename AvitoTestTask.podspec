Pod::Spec.new do |s|
  s.name         = 'AvitoTestTask'
  s.version      = '0.0.0'
  s.summary      = 'Avito-Test-Task-by-Timur-Yusipov'
  s.homepage     = 'https://github.com/Usipov/AvitoTestTask'
  s.license      = 'MIT'
  s.author       = { 'fizmatchel' => 'ykylele@gmail.com' }
  s.source       = { :git => 'https://github.com/Usipov/AvitoTestTask.git', :branch => 'master' }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  

  s.subspec 'Utils' do |utils|
    utils.source_files = 'Utils/Utils/*.{h,m,mm}'

    utils.dependency 'BlocksKit'
    utils.dependency 'Reachability'
  end

  s.subspec 'CoreData' do |coreData|
    coreData.source_files = 'CoreData/CoreData/**/*.{h,m,mm}'
    coreData.prefix_header_file = 'CoreData/CoreData/CoreData-Prefix.pch'
    coreData.resources    = 'CoreData/CoreData/**/*.{bundle,plist,xcdatamodeld}'    

    coreData.dependency 'AvitoTestTask/Utils'
    coreData.dependency 'MagicalRecord', '2.2'

    coreData.frameworks = 'CoreData'
  end

   s.subspec 'Model' do |model|
    model.source_files = 'Model/Model/**/*.{h,m,mm}'
    model.prefix_header_file = 'Model/Model/Model-Prefix.pch'
    model.resources    = 'Model/Model/**/*.{bundle,plist}'

    model.dependency 'AvitoTestTask/CoreData'    
  end

  s.subspec 'Networking' do |networking|
    networking.source_files = 'Networking/Networking/**/*.{h,m,mm}'
    networking.prefix_header_file = 'Networking/Networking/Networking-Prefix.pch'
    networking.resources    = 'Networking/Networking/**/*.{bundle,plist}'

    networking.dependency 'AvitoTestTask/Utils'
    networking.dependency 'AFNetworking'
  end

  s.subspec 'Images' do |images|
    images.source_files = 'Images/Images/**/*.{h,m,mm}'
    images.prefix_header_file = 'Images/Images/Images-Prefix.pch'
    images.resources    = 'Images/Images/**/*.{bundle,plist}'

    images.dependency 'AvitoTestTask/Networking'
  end

  s.subspec 'Interactor' do |interactor|
    interactor.prefix_header_file = 'Interactor/Interactor/Interactor-Prefix.pch'
    interactor.source_files = 'Interactor/Interactor/**/*.{h,m,mm}'
    interactor.resources    = 'Interactor/Interactor/**/*.{bundle,plist}'    

    interactor.dependency 'AvitoTestTask/Model'
    interactor.dependency 'AvitoTestTask/Images'
  end

  s.subspec 'View' do |view|
    view.prefix_header_file = 'View/View/View-Prefix.pch'
    view.source_files = 'View/View/**/*.{h,m,mm}'
    view.resources    = 'View/View/**/*.{storyboard,png,xib,bundle,plist}'

    view.dependency 'Masonry'
  end

  s.subspec 'Presenter' do |presenter|
    presenter.prefix_header_file = 'Presenter/Presenter/Presenter-Prefix.pch'
    presenter.source_files = 'Presenter/Presenter/**/*.{h,m,mm}'
    presenter.resources    = 'Presenter/Presenter/**/*.{bundle,plist}'

    presenter.dependency 'AvitoTestTask/Interactor'
    presenter.dependency 'AvitoTestTask/View'    
  end

end