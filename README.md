# PhotoApp
<p>Приложение включает в себя аутентификацию пользователя и работу с фотографиями (для нормальной работы на симуляторе, просьба отключить AutoFill и Detect compromissed password).</p>
<p>Разделы README:</p>

- [Structure](#structure)
- [Stack](#stack)
# Structure
<p>Приложение состоит из нескольких модулей:</p>
 
 - [LoginModule](#loginmodule)
 - [ProfileModule](#profilemodule)
 - [UsersModule](#usersmodule)
 - [PhotoModule](#photomodule)

<p>Все экраны на модулях сверстаны с помощью NSLayoutAnchor. Основой для хранения данных является Core Data.</p>

## LoginModule
<p>Экран аутентификации пользователя. Основой данного экрана является UIViewController. 
Пользователю необходимо войти в свой профиль.</p>
<p>В случае, если пользователя нет в БД ему необходимо зарегестрироваться.</p>
 <div style="display:flex;">
<img alt="App image" src="Screenshots/firstScreen.png" width="30%">
<img alt="App image" src="Screenshots/signUpScreen.png" width="30%">
  
<p>Если пользователь будет вводить имя которого нет в БД(картинка слева), если будет вводить имя которое уже занято(картинка справа)</p>
<div style="display:flex;">
<img alt="App image" src="Screenshots/incorrectName.png" width="30%">
<img alt="App image" src="Screenshots/tokenName.png" width="30%">

<p>При успешной авторизации пользователь переходит в свой профиль.</p>

## ProfileModule
<p>Модуль работает на основе UITabBarController & UIViewController. Экран показывает имя пользователя и его аватар.</p>
 <img alt="App image" src="Screenshots/profileScreen.png" width="30%">
<p>Пользователь может выйти из своего аккаунта(разлогиниться) или удалить его(что повлечет за собой удаление из БД). При выходе из аккаунта все измененные данные сохраняются.</p>
<p>При регистрации профиля пользователю предоставляется стандартный аватар. Пользователь может изменить свой аватар, нажав на соответствующую кнопку(переход на PhotoModule).</p>

## UsersModule
<p>Модуль работает на основе UITabBarController & UITableViewController. Экран содержит имена и аватары всех зарегистрированных пользователей, включая текущего авторизованного пользователя. Если пользователь удаляет свой профиль, он удаляется с данного экрана.</p>
<img alt="App image" src="Screenshots/usersScreen.png" width="30%">
 
## PhotoModule
<p>В данном модуле выполняется работа с локальными фотографиями и альбомами, которые интегрированы на кастомный экран. Модуль состоит из нескольких экранов:</p>

- [Photo](#photo)
- [Albums](#albums)
- [CurrentPhoto](#currentphoto)


### Photo
<p>Основой экрана являются UIViewController & CollectionView. Экран показывает локальные фотографии выбранного альбома.</p>
<img alt="App image" src="Screenshots/photosScreen.png" width="30%">
<p>Пользователь может изменить выбранный альбом нажав на соответствующую кнопку(переход на Albums). Если пользователь нажимает на любую фотографию то переходит на экран с выбранной фотографией(переход на CurrentPhoto).</p>

### Albums
<p>Основой экрана является UITableViewController. Экран содержит все локальные альбомы фотографий пользователя.</p>
<p>На данном экране пользователь выбирает альбом, фотографии которого будут изображены на предыдущем экране(Photo).</p>
<div style="display:flex;">
<img alt="App image" src="Screenshots/albumsScreen.png" width="30%">
<img alt="App image" src="Screenshots/changeAlbumScreen.png" width="30%">
  
### CurrentPhoto
<p>Основой экрана является UIViewController. Экран показывет выбранную пользователем фотографию.</p>
<img alt="App image" src="Screenshots/photoRedactor.png" width="30%">

<p>Пользователь может изменить аватар своего профиля на данную фотографию, нажав на кнопку Save, после чего внесутся изменения в БД.</p>
 <div style="display:flex;">
<img alt="App image" src="Screenshots/updateProfile.png" width="30%">
<img alt="App image" src="Screenshots/updateUsers.png" width="30%">

# Stack
- Core Data
- UITabBarController & UINavigationController
- UIViewController & UIView(Label, Button и т.д) & Alert
- UICollectionView & UICollectionViewCell
- UITableViewController & UITableViewCell
- Photos & PhotosUI





