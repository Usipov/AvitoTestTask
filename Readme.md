Тестовое задание попытался сделать с архитектурой VIPER, правда без Router'а, 
потому что решил не делать его для одного экранчика.


### Основные модули ###

1. View: 
содержит контроллер и его представления. View умеет сообщать Presenter'у о событиях. View не просит данные у Presenterэа

2. Presenter:
умеет настраивать View согласно имеющимся данным для отображения. Presenter не знает ничего про сервисы. Знает только про Interactor'а, у которого просит данные для отображения.

3. Interactor:
центрирует в себе бизнес-логику. Знает с какого url качать данные. Сам только раздает указания сервисам: сервису загрузки данных, сервису загрузки и кэширования картинок, модели

4. Model:
знает как именно хранить данные, знает как их вычитывать. Делает это через сервис

5. Router:
должен содержать flow прохождения по экранам приложения


### Кто кого retain'ит ###

Исходил из логики, что View (контроллер) и так живет в памяти посредством окошка, контроллеров навигации, таббара и других. 
Поэтому его лишний раз можно не retain'ить. View сильно ссылается на Presenter'а. Presenter сильно ссылается на Interactor'а.
Interactor сильно ссылается на сервисы. Сервисы не ссылаются на Interactor'а: общаются с ним через callback-блоки. 
Intearactor слабо ссылается на Presenter'а, чтобы давать ему данные. Presenter слабо ссылается на View, чтобы настраивать его.

Старался в каждом модуле выделить свои PONSO (NSObject'ы). 
Так сделано, чтобы обратить внимание на то, что модель редактируется только в одном месте. 
Эти PONSO к тому же как правило неизменяемые (как бонус для многопоточности). 
Создаются PONSO как правило через строителей.


### Подпроекты ###

Utils - просто набор удобных методов
CoreData - умеет инициализировать стек CoreData, знает где искать файл модели, где хранить базу данных
Model - умеет обращаться к CoreData для записи и вычитывания данных
Networking - умеет асинхронно загружать данные из сети
Images - умеет асинхронно загружать данные из сети, кэшировать их и записывать их на диск.
