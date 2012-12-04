# Приложение для создания скриншотов страниц сайтов

## Проблема, которую решает приложение
Данное приложение предназначено для автоматического создания скриншотов страниц сайтов, оборачивания их в бордер браузера Safari, автоматического сохранения полученной картинки в dropbox-аккаунт и получения публичной ссылки на эту картинку.

## Аудитория приложения
Блоггеры, контент-менеджеры, фрилансеры-дизайнеры-верстальщики.

## Пример сценария использования приложения
Пользователь запускает приложение, вставляет в поле ввода url страницы сайта, скриншот которой он хочет сделать, выбирает переключателем в каком формате необходимо сохранить скриншот и нажимает на кнопку "Get shot url". В результате в буфер обмена копируется public-ссылка на получившийся скриншот, который сохраняется и расшаривается в dropbox.

## Описание поведения
1. При загрузке приложения появляется главное окно приложения, в котором можно ввести url страницы сайта для скриншота, выбрать формат сохранения скриншота, нажать на кнопку "Получить url скриншота".
2. В поле "Input sitepage url" можно ввести (либо вставить из буфера обмена) url страницы сайта, с которой необходимо сделать скриншот. При этом надпись в этом поле при установке туда курсора будет автоматически убираться, а если поле не было заполнено и потеряло фокус, то снова автоматически появляться.
3. С помощью переключателей можно выбрать в каком формате необходимо сохранить скриншот. По умолчанию переключатель установлен в позиции "png".
4. При нажатии на кнопку "Get shot url" программа делает скриншот страницы, url которой прописан в поле ввода, оборачивает его в бордер с изображением safari и сохраняет полученную картинку в dropbox. После сохранения программа "расшаривает" эту картинку для всех, копирует полученный url в буфер обмена и извещает об этом пользователя всплывающим сообщением. Скриншоты будут сохраняться в отдельной папке с названием "sl_pageshots".