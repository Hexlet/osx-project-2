Проект 2 by iGR
=================

Приложение называется Regex Tester. 

Оно предназначено для разработчиков, которые работают с регулярными выражениями.

Регулярное выражение иногда не так просто "скомпилировать" в голове, поэтому часто возникает необходимость убедиться, что результат применения Regex-шаблона вернет нам то, что мы ожидаем. Приложение позволяет задать Regex-шаблон и исходную строку, и получить все подстроки, которые удовлетворяют шаблону.

Основной сценарий использования:
1) пользователь запускает приложение, появляется окно программы;
2) пользователь вводит в поле Pattern шаблон регулярного выражения;
3) пользователь вводит или вставляет из буфера текст исходной строки, на который будет накладываться шаблон, в поле Source;
4) если нужно, пользователь отмечает дополнительные опции Regexa;
5) пользователь нажимает кнопку Apply;
6) программа выводит в Results все подстроки, которые удовлетворяют шаблону; если в шаблоне были заданы группы, отображаются также группы для каждой подстроки;
7) найденные подстроки выделяются цветом в тексте входящей строки.

Дополнительные возможности программы:
1. Пользователь может загрузить текст входящей строки из файл: после нажатия на кнопку File появляется диалог открытия файла.
2. Пользователь может загрузить в качестве входящей строки контент из заданного URL, вставив или написав его в текстовое поле "URL".
3. Пользователь может очистить входящую текст исходной строки, нажав на кнопку Clear.
4. Подьзователь может скопировать шаблон в буфер (кнопка Copy), при этом копироваться будет шаблон в формате NSString (т.е. специальные символы Regexa предваряются бекслешем) для того, чтобы можно было его сразу вставить в код.
5. Пользователь может сохранить шаблон, дав ему имя. После этого шаблон добавится в список "Saved patterns". 
6. Пользователь может загрузить сохраненный шаблон, выбрав его в списке "Saved patterns" и нажав клавишу "enter" или сделав двойной клик. Текст шаблона появится в поле Pattern.
7. Пользователь может удалить сохраненный шаблон, нажав клавишу "delete".


