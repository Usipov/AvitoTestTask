DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"


echo ...........Utils...........
cd Utils
pod install --no-repo-update
cd ..

echo ...........CoreData...........
cd CoreData
pod install --no-repo-update
cd ..

echo ...........Model...........
cd Model
pod install --no-repo-update
cd ..

echo ...........Networking...........
cd Networking
pod install --no-repo-update
cd ..

echo ...........Images...........
cd Images
pod install --no-repo-update
cd ..

echo ...........Interactor...........
cd Interactor
pod install --no-repo-update
cd ..

echo ...........View...........
cd View
pod install --no-repo-update
cd ..

echo ...........Presenter........
cd Presenter
pod install --no-repo-update
cd ..

echo ...........Sample...........
cd Sample
pod install --no-repo-update
cd ..
