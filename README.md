Проект 2. Идея и интерфейс приложения
=====================================

Описание приложения
===================

1.  Проблема, которую решает приложение

    Любой человек пользуется системным буфером обмена - когда нужно скопировать
    какую-либо информацию и потом вставить ее в другое место. В данном случае
    проблемой является ограниченность буфера одной ячейкой. Большинство
    пользователей устраивает такое положение вещей, но некоторым одной ячейки
    мало - иногда бывает необходимо хранить в памяти несколько объектов.
    Приложение Osx-project-2 решает эту проблему, предоставляя пользователю
    почти неограниченный буфер обмена, из которого пользователь может выбирать
    данные для вставки.

2.  Аудитория приложения

    Целевой аудиторией приложения являются люди, работающие с текстом -
    разработчики, копирайтеры, редакторы, корректоры и др.
3.  Пример сценария использования приложения

* запустить приложение	
* скопировать нужное количество данных в буфер обмена (Cmd+C)
* выбрать из выпадающего списка в окне приложения нужную строку данных
* вставить выбранные текстовые данные (Cmd+V)
4. Описание поведения 

* При загрузке приложения из буфера обмена считывается количество изменений и сохраняется в переменной copyCount. Также запускается таймер с интервалом 10мс, при срабатывании которого текущее значение количества изменений буфера сравнивается с сохраненным. При несовпадении (т.е., если пользователь скопировал в буфер некие данные) значение обновляется и запускается функция copy, которая добавляет строку, лежащую в буфере обмена, в массив pasteboardContainer, а ее укороченое представление - в выпадающий список на форме. Если такая строка в списке уже есть - просто меняется currentIndex списка. 
* При выборе пользователем одного из пунктов выпадающего списка строка с соответствующим индексом, хранящаяся в массиве pasteboardContainer, записывается в буфер обмена (это происходит в функции pasteNow). 
* Приложение работает только с текстовыми данными: при попытке скопировать, например, файл, скопируется только его название. 
* Количество и общий размер хранимых приложением данных ограничены размером оперативной памяти и файла подкачки компьютера.
