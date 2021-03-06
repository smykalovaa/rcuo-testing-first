﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;


// { интерфейс тестирования

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	ОписанияТестов = Новый Массив;
	// Пример заполнения ОписанияТестов, может быть либо просто Имя теста, либо параметризуемый тест
	//1. ОписанияТестов.Добавить("ТестДолжен_");
	//2. лПараметры = Новый Структура("ПредставлениеТеста,ИмяТеста,Транзакция,Параметр", ПредставлениеТеста, имяТеста, Истина, МетаФорма_ПолноеИмя);
	//	 ОписанияТестов.Добавить(лПараметры);
	
	ОписанияТестов.Добавить("ТестДолжен_СложитьДваЧисла");
	ОписанияТестов.Добавить("ТестДолжен_ОпределитьИстину");
	
	ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов);

КонецПроцедуры

Процедура ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов)
	Для Каждого Описание Из ОписанияТестов Цикл
		Если ТипЗнч(Описание) = Тип("Строка") Тогда
			НаборТестов.Добавить(Описание);
		Иначе
			НаборТестов.Добавить(Описание.ИмяТеста, НаборТестов.ПараметрыТеста(Описание.Параметр), Описание.ПредставлениеТеста);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	НачатьТранзакцию();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Если ТранзакцияАктивна() Тогда
		ОтменитьТранзакцию();
	КонецЕсли;	
КонецПроцедуры

// } интерфейс тестирования


//{ блок юнит-тестов - САМИ ТЕСТЫ
Процедура ТестДолжен_СложитьДваЧисла() Экспорт
	Утверждения.ПроверитьРавенство(2+2, 4, "2+2=4");
КонецПроцедуры

Процедура ТестДолжен_ОпределитьИстину() Экспорт
	Ожидаем.Что(5).Равно(6);
КонецПроцедуры


//}
