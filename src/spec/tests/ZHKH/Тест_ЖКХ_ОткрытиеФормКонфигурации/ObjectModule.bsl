﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;

Перем ТестируемаяФорма;
Перем НужноИсключениеЕслиНеНайденоДокументов;

//{ интерфейс тестирования

// директива препроцессора нужна для исключения ошибки загрузки в толстом клиенте управляемого приложения
#Если ТолстыйКлиентОбычноеПриложение Тогда

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	НужноИсключениеЕслиНеНайденоДокументов = Ложь;
		
		Если НЕ СоздатьФорму_ПолучениеФорм() Тогда
			Возврат;
		КонецЕсли;
		
		СоздатьИменаОсновныхФорм();	
		
		ВыводитьСообщенияВЖурналРегистрации = Истина;

		Для Каждого МетаОбъект Из Метаданные.Справочники Цикл
			Если ПравоДоступа("Редактирование", МетаОбъект) Тогда
				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ОткрытьФормуСуществующегоЭлементаСправочника", ПолучитьСписокИсключений_Справочники_Существующие(), 
					мИменаОсновныхФорм_Объекты, "Существующие элементы");
			КонецЕсли;
				
			Если ПравоДоступа("ИнтерактивноеДобавление", МетаОбъект) Тогда
				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ОткрытьФормуНовогоЭлементаСправочника", ПолучитьСписокИсключений_Справочники_Новые(), 
					мИменаОсновныхФорм_Объекты, "Новые элементы");
			КонецЕсли;
			
			Если ПравоДоступа("Добавление", МетаОбъект)  Тогда
				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ОткрытьФормуНовогоЭлементаСправочникаСоздаваемогоКопированием", ПолучитьСписокИсключений_Справочники_Новые(), 
					мИменаОсновныхФорм_Объекты, "Новые через копирование элементы");
			КонецЕсли;
				
			ДобавитьТестДляМетаданного_ОдинОбъект(НаборТестов, МетаОбъект, "ТестДолжен_ОткрытьФорму_ПоМетаФорме", ПолучитьСписокИсключений_Справочники_Списки(), мИменаОсновныхФорм_Списки);
		КонецЦикла;
		
		Для Каждого МетаОбъект Из Метаданные.Документы Цикл
			Если ПравоДоступа("Редактирование", МетаОбъект) Тогда
				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ОткрытьФормуСуществующегоДокумента", ПолучитьСписокИсключений_Документы_Существующие(),
					мИменаОсновныхФорм_Объекты, "Существующие документы");

				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ПеренестиДокументНаТекущийДень_и_ОткрытьЕгоФорму", ПолучитьСписокИсключений_Документы_ПеренестиДату(),
					мИменаОсновныхФорм_Объекты, "Перенос документа на текущий день");
			КонецЕсли;
					
			Если ПравоДоступа("ИнтерактивноеДобавление", МетаОбъект) Тогда
				ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, "Тест_ОткрытьФормуНовогоДокумента", ПолучитьСписокИсключений_Документы_Новые(),
					мИменаОсновныхФорм_Объекты, "Новые документы");
			КонецЕсли;
				
			ДобавитьТестДляМетаданного_ОдинОбъект(НаборТестов, МетаОбъект, "ТестДолжен_ОткрытьФорму_ПоМетаФорме", ПолучитьСписокИсключений_Документы_Списки(), мИменаОсновныхФорм_Списки);
		КонецЦикла;
		
		ДобавитьТестПоМенеджеруМетаданных(НаборТестов, Метаданные.Отчеты, "ТестДолжен_ОткрытьФорму_ПоМетаФорме", ПолучитьСписокИсключений_Отчеты(), мИменаОсновныхФорм);
		ДобавитьТестПоМенеджеруМетаданных(НаборТестов, Метаданные.Обработки, "ТестДолжен_ОткрытьФорму_ПоМетаФорме", ПолучитьСписокИсключений_Обработки(), мИменаОсновныхФорм);
		
КонецПроцедуры

#КонецЕсли

//}

Процедура ПередЗапускомТеста() Экспорт
	ВыводитьСообщенияВЖурналРегистрации = Истина;
	
	НужноИсключениеЕслиНеНайденоДокументов = Ложь;
	
	СоздатьФорму_ПолучениеФорм();
	
	НачатьТранзакцию();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	ЗакрытьФорму();
	
	Если ТранзакцияАктивна() Тогда
		ОтменитьТранзакцию();
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗакрытьФорму()
	Если ТипЗнч(ТестируемаяФорма) <> Тип("Форма") и ТипЗнч(ТестируемаяФорма) <> Тип("УправляемаяФорма") Тогда
		Возврат;
	КонецЕсли; 
	ТестируемаяФорма.Модифицированность = Ложь;
	Если ТестируемаяФорма.Открыта() Тогда
		ТестируемаяФорма.Модифицированность = Ложь;
		Попытка
			ТестируемаяФорма.Закрыть();
		Исключение
			Ошибка = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			Если ТранзакцияАктивна() Тогда
				ОтменитьТранзакцию();
			КонецЕсли;

			НачатьТранзакцию();
			ТестируемаяФорма.УстановитьДействие("ПередЗакрытием", Неопределено);
			ТестируемаяФорма.УстановитьДействие("ПриЗакрытии", Неопределено);
			ТестируемаяФорма.Закрыть();
			ВызватьИсключение Ошибка; 			
		КонецПопытки;
	Иначе
		Попытка
			ТестируемаяФорма.Закрыть();
		Исключение
		КонецПопытки;
	КонецЕсли;
	ТестируемаяФорма = "";

КонецПроцедуры

//{ блок работы с обычными и управляемыми формами - портирован из "Инструменты разработчика"
Процедура ТестДолжен_ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, ЕстьТранзакция) Экспорт
	//Если ЕстьТранзакция Тогда
	//	НачатьТранзакцию();
	//КонецЕсли;
	
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя);
	
	//Если ЕстьТранзакция Тогда
	//	Если ТранзакцияАктивна() Тогда
	//		ОтменитьТранзакцию();
	//	КонецЕсли;
	//КонецЕсли;
КонецПроцедуры

Процедура ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма_Имя = "", СсылкаОбъектаИлиСамОбъект = Неопределено, СоздаватьОбъект = Ложь) Экспорт
	
	ВыводитьСообщения = Ложь;
	ВнешнийОбъект = Неопределено;
	КлючВременнойФормы = "908насмь9ыв";
	
	ИмяОперации = МетаФорма_ПолноеИмя;
	Если ВыводитьСообщения Тогда
		Сообщить(ИмяОперации);
	КонецЕсли; 
	Если ВыводитьСообщенияВЖурналРегистрации Тогда
		ЗаписьЖурналаРегистрации(Метаданные().Синоним, УровеньЖурналаРегистрации.Информация, , , "Операция: " + ИмяОперации);
	КонецЕсли;

	Форма = ПолучитьНовуюФорму(МетаФорма_ПолноеИмя, ВнешнийОбъект, КлючВременнойФормы);
	Если Форма = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЭтоФормаСсылочногоОбъекта = Ложь;
	Если СсылкаОбъектаИлиСамОбъект <> Неопределено Тогда
		ЭтоФормаСсылочногоОбъекта = Истина;
	Иначе
		Если ЭтоОбычнаяФорма(Форма) Тогда
			Попытка
				Пустышка = Форма.ЭтотОбъект.ЭтоНовый();
				ЭтоФормаСсылочногоОбъекта = Истина;
			Исключение
			КонецПопытки;
		Иначе
			Если Форма.Параметры.Свойство("Ключ") Тогда
				Попытка
					Пустышка = Форма.Параметры.Ключ.Ссылка;
					ЭтоФормаСсылочногоОбъекта = Истина;
				Исключение
				КонецПопытки;
			КонецЕсли; 
		КонецЕсли; 
		Если ЭтоФормаСсылочногоОбъекта Тогда
			Если ЭтоОбычнаяФорма(Форма) Тогда
				СсылкаОбъектаИлиСамОбъект = Форма.Ссылка;
			Иначе
				СсылкаОбъектаИлиСамОбъект = Форма.Параметры.Ключ;
			КонецЕсли; 
		КонецЕсли;
	КонецЕсли;
	
	Если ЭтоФормаСсылочногоОбъекта Тогда
		Если ЭтоОбычнаяФорма(Форма) Тогда
			Если СоздаватьОбъект Тогда
				Если СсылкаОбъектаИлиСамОбъект <> Неопределено Тогда
					СсылочныйОбъект = СсылкаОбъектаИлиСамОбъект.Скопировать();
					//Иначе
					//	СсылочныйОбъект = СсылкаОбъектаИлиСамОбъект.Метаданные;
				КонецЕсли;
			Иначе
				СсылочныйОбъект = СсылкаОбъектаИлиСамОбъект;
			КонецЕсли;
			Форма = СсылочныйОбъект.ПолучитьФорму(МетаФорма_Имя, , КлючВременнойФормы);
		Иначе
			ПараметрыФормы = Новый Структура;
			ЭтоОбъект = Ложь;
			Попытка
				Пустышка = СсылкаОбъектаИлиСамОбъект.ЭтотОбъект;
				ЭтоОбъект = Истина;
			Исключение
			КонецПопытки;
			Если СоздаватьОбъект Тогда
				Если Не ЭтоОбъект Тогда
					ПараметрыФормы.Вставить("ЗначениеКопирования", СсылкаОбъектаИлиСамОбъект);
				КонецЕсли;
			ИначеЕсли Не ЭтоОбъект Тогда
				ПараметрыФормы.Вставить("Ключ", СсылкаОбъектаИлиСамОбъект);
			КонецЕсли;
			Форма = ПолучитьФормуЛкс(МетаФорма_ПолноеИмя, ПараметрыФормы, , КлючВременнойФормы);
		КонецЕсли; 
	КонецЕсли;
	ТестироватьФорму(Форма, ИмяОперации);
КонецПроцедуры

Процедура СоздатьИменаОсновныхФорм() Экспорт
	Если Не ЗначениеЗаполнено(мИменаОсновныхФорм) Тогда
		мИменаОсновныхФорм = Новый Массив();
	КонецЕсли;
	СоздатьИменаОсновныхФорм_Объекты();
	СоздатьИменаОсновныхФормСписка();
	Для каждого эл Из мИменаОсновныхФорм_Объекты Цикл
		мИменаОсновныхФорм.Добавить(эл);
	КонецЦикла;
	Для каждого эл Из мИменаОсновныхФорм_Списки Цикл
		мИменаОсновныхФорм.Добавить(эл);
	КонецЦикла;
КонецПроцедуры

Процедура СоздатьИменаОсновныхФорм_Объекты()
	Если Не ЗначениеЗаполнено(мИменаОсновныхФорм_Объекты) Тогда
		мИменаОсновныхФорм_Объекты = Новый Массив();
	КонецЕсли;
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФорма");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаОбъекта");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаГруппы");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаЗаписи");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаНастроек");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаСохранения");
	мИменаОсновныхФорм_Объекты.Добавить("ОсновнаяФормаЗагрузки");
	
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФорма");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаОбъекта");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаГруппы");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаЗаписи");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаНастроек");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаСохранения");
	мИменаОсновныхФорм_Объекты.Добавить("ДополнительнаяФормаЗагрузки");
КонецПроцедуры

Процедура СоздатьИменаОсновныхФормСписка()
	Если Не ЗначениеЗаполнено(мИменаОсновныхФорм_Списки) Тогда
		мИменаОсновныхФорм_Списки = Новый Массив();
	КонецЕсли;
	мИменаОсновныхФорм_Списки.Добавить("ОсновнаяФормаСписка");
	мИменаОсновныхФорм_Списки.Добавить("ОсновнаяФормаДляВыбора");
	мИменаОсновныхФорм_Списки.Добавить("ОсновнаяФормаДляВыбораГруппы");
	мИменаОсновныхФорм_Списки.Добавить("ОсновнаяФормаКонстант");
	
	мИменаОсновныхФорм_Списки.Добавить("ДополнительнаяФормаСписка");
	мИменаОсновныхФорм_Списки.Добавить("ДополнительнаяФормаДляВыбора");
	мИменаОсновныхФорм_Списки.Добавить("ДополнительнаяФормаДляВыбораГруппы");
	мИменаОсновныхФорм_Списки.Добавить("ДополнительнаяФормаКонстант");
КонецПроцедуры

Функция СоздатьФорму_ПолучениеФорм()
	Попытка
		мПолучениеФорм = ПолучитьФорму("ПолучениеФорм"); // в управляемом режиме здесь будет ошибка выполнения
		Возврат Истина;
	Исключение
	КонецПопытки;
	Возврат Ложь;
КонецФункции

Функция ПолучитьМетаФормыОбъектаДляПроверки(МетаОбъект, ИменаОсновныхФорм) Экспорт
	
	ИспользоватьУФ = Метаданные.ИспользоватьУправляемыеФормыВОбычномПриложении;
	МетаФормы = Новый Массив();
	Для Каждого ИмяОсновнойФормы Из ИменаОсновныхФорм Цикл
		Попытка
			МетаФорма = МетаОбъект[ИмяОсновнойФормы];
		Исключение
			Продолжить;
		КонецПопытки;
		Если МетаФорма = Неопределено Тогда
			Продолжить;
		КонецЕсли; 
		Если МетаФормы.Найти(МетаФорма) <> Неопределено Тогда
			Продолжить;
		КонецЕсли; 
		Если НЕ ИспользоватьУФ И МетаФорма.ТипФормы = Метаданные.СвойстваОбъектов.ТипФормы.Управляемая Тогда
			Продолжить;
		КонецЕсли;
		МетаФормы.Добавить(МетаФорма);
	КонецЦикла;
	Возврат МетаФормы;
	
КонецФункции

Функция ПолучитьФормуЛкс(ИмяФормы, Параметры = Неопределено, Владелец = Неопределено, Уникальность = Неопределено, Окно = Неопределено) Экспорт
	
	Возврат мПолучениеФорм.ПолучитьФормуЛкс(ИмяФормы, Параметры, Владелец, Уникальность, Окно);
	
КонецФункции

Функция ПолучитьНовуюФорму(МетаФорма, ВнешнийОбъект = Неопределено, КлючВременнойФормы = Неопределено)

	Форма = ПолучитьФормуЛкс(МетаФорма, , , КлючВременнойФормы); //ирНеглобальный.
	Возврат Форма;

КонецФункции

Процедура ТестироватьФорму(Форма, ИмяОперации = "") Экспорт
	ТестируемаяФорма = Форма;
	Форма.Открыть(); // К сожалению здесь исключения не ловятся http://partners.v8.1c.ru/forum/thread.jsp?id=1080350#1080350
		Утверждения.Проверить(ТестируемаяФорма.Открыта(), "ТестируемаяФорма """+ИмяОперации+""" не открылась, а должна была открыться");
		
	// Артур - мой код для доп.проверки формы
	Если ЭтоОбычнаяФорма(ТестируемаяФорма) Тогда
		ТестируемаяФорма.Обновить();
	Иначе
		ТестируемаяФорма.ОбновитьОтображениеДанных();
	КонецЕсли;

КонецПроцедуры

//} конец блока работы с управляемыми формами - из "Инструменты разработчика"

Функция ЭтоОбычнаяФорма(Форма)
	Возврат ТипЗнч(Форма) = Тип("Форма");
КонецФункции

Процедура ДобавитьТестПоМенеджеруМетаданных(НаборТестов, менеджерМетаданного, имяТеста, списокИсключений, ИменаОсновныхФорм)
	Для Каждого МетаОбъект Из менеджерМетаданного Цикл
		ДобавитьТестДляМетаданного_ОдинОбъект(НаборТестов, МетаОбъект, имяТеста, списокИсключений, ИменаОсновныхФорм);
	КонецЦикла;
КонецПроцедуры

Процедура ДобавитьТестДляМетаданного_ОдинОбъект(НаборТестов, МетаОбъект, имяТеста, списокИсключений, ИменаОсновныхФорм)
	Если списокИсключений.НайтиПоЗначению(МетаОбъект.Имя) <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоУстаревшийМетаОбъектДляУдаления(МетаОбъект) Тогда
		Возврат;
	КонецЕсли;
	Если ПравоДоступа("Просмотр", МетаОбъект) Тогда
		МетаФормы = ПолучитьМетаФормыОбъектаДляПроверки(МетаОбъект, ИменаОсновныхФорм);

		Для каждого МетаФорма Из МетаФормы Цикл
			МетаФорма_ПолноеИмя = МетаФорма.ПолноеИмя();
			
			Если Метаданные.ОсновнаяФормаОтчета = МетаФорма Тогда
				МетаФорма_ПолноеИмя = МетаОбъект.ПолноеИмя() + ".Форма";
			КонецЕсли;
			
			ПредставлениеТеста = МетаФорма_ПолноеИмя;
			//лПараметры = Новый Структура("ПредставлениеТеста,ИмяТеста,Транзакция,Параметр", ПредставлениеТеста, имяТеста, Истина, МетаФорма_ПолноеИмя);
			//НаборТестов.Добавить(лПараметры);
			ЕстьТранзакция = Истина;
			НаборТестов.Добавить(имяТеста, НаборТестов.ПараметрыТеста(МетаФорма_ПолноеИмя, ЕстьТранзакция), ПредставлениеТеста);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьТестДляОдногоМетаданного_Объекты(НаборТестов, МетаОбъект, имяТеста, списокИсключений, ИменаОсновныхФорм, ПрефиксПредставленияТеста)
	Если списокИсключений.НайтиПоЗначению(МетаОбъект.Имя) <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ЭтоУстаревшийМетаОбъектДляУдаления(МетаОбъект) Тогда
		Возврат;
	КонецЕсли;
	Если ПравоДоступа("Просмотр", МетаОбъект) и ПравоДоступа("Добавление", МетаОбъект) 
		Тогда
			МетаФормы = ПолучитьМетаФормыОбъектаДляПроверки(МетаОбъект, ИменаОсновныхФорм);
			Для каждого МетаФорма Из МетаФормы Цикл
				МетаФорма_ПолноеИмя = МетаФорма.ПолноеИмя();
				ПредставлениеТеста = ПрефиксПредставленияТеста + " : " + МетаФорма_ПолноеИмя;
				//Структура = Новый Структура("МетаИмя,МетаФорма_ПолноеИмя,МетаФорма", МетаОбъект.Имя, МетаФорма_ПолноеИмя, МетаФорма);
				//лПараметры = Новый Структура("ПредставлениеТеста,ИмяТеста,Транзакция,Параметр", ПредставлениеТеста, имяТеста, Истина, Структура);
				//НаборТестов.Добавить(лПараметры);
				ЕстьТранзакция = Истина;
				НаборТестов.Добавить(имяТеста, НаборТестов.ПараметрыТеста(МетаОбъект.Имя, МетаФорма_ПолноеИмя, МетаФорма, ЕстьТранзакция), ПредставлениеТеста);
			КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Функция ЭтоУстаревшийМетаОбъектДляУдаления(МетаОбъект) Экспорт
	Возврат Найти(НРег(МетаОбъект.Имя), НРег("Удалить")) = 1;
КонецФункции

Процедура Тест_ОткрытьФормуСуществующегоДокумента(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Док = ПолучитьСуществующийДокументОбъект(ИД, НужноИсключениеЕслиНеНайденоДокументов, "Тест_ОткрытьФормуСуществующегоДокумента");
		
	Если Док <> Неопределено Тогда
		ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Док.Ссылка);
	КонецЕсли;
КонецПроцедуры

Процедура Тест_ПеренестиДокументНаТекущийДень_и_ОткрытьЕгоФорму(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Док = ПолучитьСуществующийДокументОбъект(ИД, Ложь, "Тест_ПеренестиДокументНаТекущийДень_и_ОткрытьЕгоФорму");
	Если Док = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Док.Дата = ТекущаяДата();
	Док.ОбменДанными.Загрузка = Истина;
	Док.Записать();
	
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Док.Ссылка);
КонецПроцедуры

Процедура Тест_ОткрытьФормуНовогоДокумента(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Док = Документы[ИД].СоздатьДокумент();
	Мета = Док.Метаданные();
	Если НЕ ПравоДоступа("ИнтерактивноеДобавление", Мета) Тогда
		Возврат;
	КонецЕсли;
	Если Мета.ДлинаНомера <> 0 Тогда
		Попытка
			Док.УстановитьНовыйНомер();
		Исключение
		КонецПопытки;
	КонецЕсли;
	
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Док, Ложь);
КонецПроцедуры

Функция ПолучитьСуществующийДокументОбъект(ИД, НужноИсключениеЕслиНеНайденоДокументов, ДопОписаниеДляИсключения)
	выборка = Документы[ИД].Выбрать(,,, "Дата Убыв");
	уcпешно = выборка.Следующий();
	Если Не уcпешно Тогда
		Если НужноИсключениеЕслиНеНайденоДокументов Тогда
			ВызватьИсключение ДопОписаниеДляИсключения + ": выборка.Следующий() - не найдено существующих документов! ";
		Иначе
			Возврат Неопределено;
		КонецЕсли;
	КонецЕсли;
	Док = выборка.ПолучитьОбъект();
	Возврат Док;
КонецФункции

Функция ПолучитьСуществующийДокументОбъектИВернутьСсылку(ИД, НужноИсключениеЕслиНеНайденоДокументов, ДопОписаниеДляИсключения) Экспорт
	Док = ПолучитьСуществующийДокументОбъект(ИД, НужноИсключениеЕслиНеНайденоДокументов, ДопОписаниеДляИсключения);
	Возврат ?(Док = Неопределено, Неопределено, Док.Ссылка);
КонецФункции

Процедура Тест_ОткрытьФормуСуществующегоЭлементаСправочника(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Элем = СоздатьЭлемент(ИД, "существующий");
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Элем.Ссылка);
КонецПроцедуры

Процедура Тест_ОткрытьФормуНовогоЭлементаСправочника(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Элем = Справочники[ИД].СоздатьЭлемент();
	Мета = Элем.Метаданные();
	Если НЕ ПравоДоступа("ИнтерактивноеДобавление", Мета) Тогда
		Возврат;
	КонецЕсли;
	Если Мета.ДлинаНаименования <> 0 Тогда
		Попытка
			Элем.Наименование = "новый";
		Исключение
		КонецПопытки;
	КонецЕсли;
	
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Элем, Ложь);
КонецПроцедуры

Процедура Тест_ОткрытьФормуНовогоЭлементаСправочникаСоздаваемогоКопированием(МетаИмя,МетаФорма_ПолноеИмя,МетаФорма, ЕстьТранзакция) Экспорт
	ИД = МетаИмя;
	Элем = СоздатьЭлемент(ИД, "копирование", "ИнтерактивноеДобавление");
	Если Элем = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФорму_ПоМетаФорме(МетаФорма_ПолноеИмя, МетаФорма.Имя, Элем.Ссылка, Истина);
КонецПроцедуры

Функция СоздатьЭлемент(ИД, Наименование, ПроверяемоеПравоДоступа = Неопределено)
	Элем = Справочники[ИД].СоздатьЭлемент();
	Мета = Элем.Метаданные();
	Если ПроверяемоеПравоДоступа <> Неопределено И НЕ ПравоДоступа(ПроверяемоеПравоДоступа, Мета) Тогда
		Возврат Неопределено;
	КонецЕсли;

	Если Мета.ДлинаНаименования <> 0 Тогда
		Попытка
			Элем.Наименование = Наименование;
		Исключение
		КонецПопытки;
	КонецЕсли;
	
	Если Мета.ДлинаКода <> 0 Тогда
		Элем.УстановитьНовыйКод();
	КонецЕсли;
	Элем.ОбменДанными.Загрузка = Истина;
	Элем.Записать();
	Возврат Элем;
КонецФункции

Функция СоздатьЭлементИВернутьСсылку(ИД, Наименование, ПроверяемоеПравоДоступа = Неопределено) Экспорт
	Элем = СоздатьЭлемент(ИД, Наименование, ПроверяемоеПравоДоступа);
	Возврат ?(Элем = Неопределено, Неопределено, Элем.Ссылка);
КонецФункции

//{ блок переопределения исключений, чтобы не открывать формы
Функция ПолучитьСписокИсключений_Справочники_Списки() Экспорт
	Результат = Новый СписокЗначений;
	
	Результат.Добавить("ирАлгоритмы");
	//+ ЖКХ
	Результат.Добавить("СоглашенияОбИспользованииЭД");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ВариантыОтчетов");
	Результат.Добавить("УчетныеЗаписиДокументооборота");
	Результат.Добавить("СообщенияСистемы");
	Результат.Добавить("ИдентификаторыОбъектовМетаданных");
	Результат.Добавить("ПодключаемоеОборудование");
	Результат.Добавить("СообщенияОбластейДанных");
	Результат.Добавить("ркПаспортДомаПараметры");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Справочники_Существующие() Экспорт
	Результат = Новый СписокЗначений;
	
	Результат.Добавить("ирАлгоритмы");
	//+ ЖКХ
	Результат.Добавить("СоглашенияОбИспользованииЭД");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ВариантыОтчетов");
	Результат.Добавить("УчетныеЗаписиДокументооборота");
	Результат.Добавить("СообщенияСистемы");
	Результат.Добавить("ИдентификаторыОбъектовМетаданных");
	Результат.Добавить("ПодключаемоеОборудование");
	Результат.Добавить("СообщенияОбластейДанных");
	Результат.Добавить("ркПаспортДомаПараметры");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Справочники_Новые() Экспорт
	Результат = Новый СписокЗначений;
	
	Результат.Добавить("ирАлгоритмы");
	//+ ЖКХ
	Результат.Добавить("СоглашенияОбИспользованииЭД");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ЭДПрисоединенныеФайлы");
	Результат.Добавить("ВариантыОтчетов");
	Результат.Добавить("УчетныеЗаписиДокументооборота");
	Результат.Добавить("СообщенияСистемы");
	Результат.Добавить("ИдентификаторыОбъектовМетаданных");
	Результат.Добавить("ПодключаемоеОборудование");
	Результат.Добавить("СообщенияОбластейДанных");
	Результат.Добавить("ркПаспортДомаПараметры");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Документы_Списки() Экспорт
	Результат = Новый СписокЗначений;
	
	//Результат.Добавить("Штрафы");
	//+ ЖКХ
	Результат.Добавить("ркЧекККМВозврат");
	Результат.Добавить("ркЧекККМ");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Документы_Существующие() Экспорт
	Результат = Новый СписокЗначений;
	
	//Результат.Добавить("Штрафы");
	//+ ЖКХ
	Результат.Добавить("ркЧекККМВозврат");
	Результат.Добавить("ркЧекККМ");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Документы_ПеренестиДату() Экспорт
	Результат = Новый СписокЗначений;
	
	//Результат.Добавить("Штрафы");
	//+ ЖКХ
	Результат.Добавить("ркЧекККМВозврат");
	Результат.Добавить("ркЧекККМ");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Документы_Новые() Экспорт
	Результат = Новый СписокЗначений;
	
	//Результат.Добавить("Штрафы");
	//+ ЖКХ
	Результат.Добавить("ркЧекККМВозврат");
	Результат.Добавить("ркЧекККМ");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Отчеты() Экспорт
	Результат = Новый СписокЗначений;
	
	//Результат.Добавить("Цены");
	//+ ЖКХ
	Результат.Добавить("ПраваДоступа");
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокИсключений_Обработки() Экспорт
	Результат = Новый СписокЗначений;
	
	Результат.Добавить("ТестОбработка_Форма_ИсключениеПриОткрытии");
	//+ ЖКХ
	Результат.Добавить("СопоставлениеОбъектовИнформационныхБаз");
	Результат.Добавить("ркОЗОплатаБанковскийПроцент");
	Результат.Добавить("КонвертацияОбъектовРаспределенныхИнформационныхБаз");
	Результат.Добавить("ПомощникСозданияАвтономногоРабочегоМеста");
	Результат.Добавить("СопоставлениеОбъектовИнформационныхБаз");
	Результат.Добавить("ркОЗНепредоставлениеПоказанийНормативное");
	Результат.Добавить("ПомощникНастройкиСинхронизацииДанныхМеждуПриложениямиВИнтернете");
	Результат.Добавить("ркОЗДокументПоказанияГрупповыхСчетчиковПоБазе");
	Результат.Добавить("ПомощникИнтерактивногоОбменаДаннымиВМоделиСервиса");
	Результат.Добавить("НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервиса");
	Результат.Добавить("НастройкаРазрешенийНаИспользованиеВнешнихРесурсов");
	Результат.Добавить("ИнформационныйЦентр");
	Результат.Добавить("ПереносФайловВТома");
	Результат.Добавить("ВводКонтактнойИнформации");
	Результат.Добавить("ПанельАдминистрированияБСП");
	Результат.Добавить("ЗагрузкаПравилРегистрацииОбъектов");
	Результат.Добавить("ПомощникСозданияОбменаДанными");
	Результат.Добавить("ИнтерактивноеИзменениеВыгрузки");
	Результат.Добавить("РекомендацияПоПовышениюСкоростиРаботы");
	Результат.Добавить("ЛегальностьПолученияОбновлений");
	Результат.Добавить("КонвертацияОбъектовИнформационныхБаз");
	Результат.Добавить("ЗаменаИОбъединениеЭлементов");
	Результат.Добавить("ркРабочееМестоПаспортиста");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	Результат.Добавить("ЗагрузкаКурсовВалют");
	
	Возврат Результат;
КонецФункции
//} конец блока