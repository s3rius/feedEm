<h1 align="left">
   FeedEm проект для предзаказа еды.
</h1>

### FeedEm - платформа для предзаказов еды.

# Роли пользователей:

* Покупатель
* Продавец
* Администратор

# Сценарии использования

## BG-1: Уменьшить время ожидания для покупателей.

### F1-1: Заказ покупателя будет готов, когда он прибудет в ресторан.

Как покупателю, многим хотелось бы получать свои заказы так быстро, как это возможно.

Данное приложение позволит вам совершать предзаказ и получать еду к назначенному времени.

Пользователю предоставляется выбор ресторана, где он может совершить заказ.
В каждом ресторане имеется меню возможных товаров. После составления заказа, пользователю предлагается выбор времени, к которому заказ должен быть приготовлен.  

### F1-2: Никаких очередей.

Сервис feeEm *не* имеет очередей ожидания. 
Всё, что понадобится для заказа - соединение с сетью интернет.

Заказ пользователя готовится к назначенному времени и вместо ожидания в очереди нужно только забрать заказ.

## BG-2: Увеличение дохода ресторана.

### F2-1: Не требуется доплата за сервис доставки.

FeedEm создан не для доставки, а для предзаказов.
Цель продавцов - подготовка еды к нужному для клинтов времени. 
Покупатели сам придут, чтобы получить заказ.

Владельцы ресторанов могут регестрировать свои заведения в приложении. После регистрации появляется возможность редактирования меню. 
При составлении меню возможно указать:
* Название товара
* Цену товара
* Описание
* Примерное время готовки 

Позже меню может быть отредактировано в личном кабинете. 

### F2-2: Не требуется создавать собственное приложение.

<a href="https://www.bk.com">BurgerKing™</a> имеет собственное приложение для предзаказов, но написание подобного рода приложений затратно.
И мы предлагаем вам наше решение.

После регистрации продавцу выдается уникальный токен, по которому продавец может совершать вход в личный кабинет.
Токен может быть перевыдан по запросу продавца.

### F2-3: Бесплатная реклама. 

Если предлагаемая вами еда высоко ценится клиентами, то новые покупатели сами найдут вас. 
Чем выше будет ваш рейтинг, тем больше людей узнают о вас.

Также в feedEm ведется учёт рейтинга продавца. Чем больше положительных отзывов, тем выше будет продавец в поисковых запросах.

# Компоненты

## Модели (М в модели MVC)
Смотрите ER-диаграмму.

Реализованы как модели в Ruby on rails.

Данные хранятся в Postgresql.

* Покупатели
* Кредитные карточки
* Продавцы
* Товары
* Заказы

## Отображения (V в модели MVC)
Реализованы как отображения в Ruby on rails.

Используется Vue js фраемворк на стороне клиента.

* Домашняя страница
* Страница поиска
* Страница товара
* Страница заказа товара
* Страница профиля пользователя
* Страница входа для пользователя
* Страница регистрации пользователя
* Страница профиля продавца
* Страница входа для продавца
* Панель администратора

## Контроллеры (C в модели MVC)
Реализованы как контроллеры в Ruby on Rails.

* Контроллер пользователя
* Контроллер продавца
* Контроллер заказа
* Контроллер товара
* Контроллер кредитных карт

