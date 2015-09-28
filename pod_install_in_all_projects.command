DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"


echo ...........Utils...........
cd Utils
pod install
cd ..

echo ...........CoreData...........
cd CoreData
pod install
cd ..

echo ...........Core...........
cd Core
pod install
cd ..

echo ...........Model...........
cd Model
pod install
cd ..

echo ...........Networking...........
cd Networking
pod install
cd ..

echo ...........Images...........
cd Images
pod install
cd ..

echo ...........Interactor...........
cd Interactor
pod install
cd ..

echo ...........View...........
cd View
pod install
cd ..

echo ...........Presenter........
cd Presenter
pod install
cd ..

echo ...........Sample...........
cd Sample
pod install
cd ..
