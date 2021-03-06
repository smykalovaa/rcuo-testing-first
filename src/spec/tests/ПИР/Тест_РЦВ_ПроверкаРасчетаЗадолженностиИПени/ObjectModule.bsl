﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;
Перем СериализаторMXL;
Перем УтвержденияПроверкаТаблиц;
Перем ТабДок_Эталон;
Перем ТабДок_ДляАнализа;


#Область ИнтерфейсТестирования

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	СериализаторMXL = КонтекстЯдра.Плагин("СериализаторMXL");
	УтвержденияПроверкаТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	ОписанияТестов = Новый Массив;
	// Пример заполнения ОписанияТестов, может быть либо просто Имя теста, либо параметризуемый тест
	//1. ОписанияТестов.Добавить("ТестДолжен_");
	//2. лПараметры = Новый Структура("ПредставлениеТеста,ИмяТеста,Транзакция,Параметр", ПредставлениеТеста, имяТеста, Истина, МетаФорма_ПолноеИмя);
	//	 ОписанияТестов.Добавить(лПараметры);
	
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030911");
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Пени_00000000000030911");
	
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000104105");
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Пени_00000000000104105");
	
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030363");
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Пени_00000000000030363");
	
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084211");
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Пени_00000000000084211");
	
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084360");
	ОписанияТестов.Добавить("ТестДолжен_ПроверитьРасчет_Пени_00000000000084360");
	
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

#КонецОбласти


#Область БлокUnitТестов

Процедура ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030911() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000030911");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030911", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Пени_00000000000030911() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000030911");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
	
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводПрямогоРезультатвТД(Состав, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Пени_00000000000030911", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Задолженности_00000000000104105() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000104105");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000104105", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Пени_00000000000104105() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000104105");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
	
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводПрямогоРезультатвТД(Состав, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Пени_00000000000104105", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030363() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000030363");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000030363", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Пени_00000000000030363() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000030363");
	ДатаРасчета = Дата(2016,11,22);
	НачалоПериода = Дата(2016,7,1);
	КонецПериода = Дата(2016,9,30);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000000001");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);	
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
	
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводПрямогоРезультатвТД(Состав, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Пени_00000000000030363", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084211() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084211");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084211", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Пени_00000000000084211() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084211");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	УК = Справочники.Контрагенты.НайтиПоНаименованию("ООО ""Уютный дом""");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);
	ПараметрыОтбора.Вставить("УК",УК);
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
	
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводПрямогоРезультатвТД(Состав, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Пени_00000000000084211", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084360() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084360");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	рцПИРаботаСервер.ПолучитьБлокДанныхДляСправкиПоЗадолженности(СтруктураДанных, ЛицевойСчет, ДатаРасчета, НачалоПериода, КонецПериода, ,НаборВидовРасчета);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводДЗвТД(СтруктураДанных.ДетализацияПоЗадолженности, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Задолженности_00000000000084360", ТабДок_ДляАнализа);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРасчет_Пени_00000000000084360() Экспорт

	СтруктураДанных = Новый Структура;
	ЛицевойСчет = Справочники.ркЛицевыеСчета.НайтиПоКоду("00000000000084360");
	ДатаРасчета = Дата(2016,11,25);
	НачалоПериода = Дата(1,1,1);
	КонецПериода = Дата(2016,10,31);
	НаборВидовРасчета = Справочники.ркНаборыВидовРасчета.НайтиПоКоду("000001003");
	УК = Справочники.Контрагенты.НайтиПоНаименованию("ООО ""Уютный дом""");
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Ссылка",Документы.рцРаботаСИсками.ПустаяСсылка());
	ПараметрыОтбора.Вставить("Тип",Перечисления.рцВидыДокументовПИР.ПустаяСсылка());
	ПараметрыОтбора.Вставить("ДатаРасчета",ДатаРасчета);
	ПараметрыОтбора.Вставить("ДатаМероприятий",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаДвиженияИсков",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРаботыСИскам",Дата(1,1,1));
	ПараметрыОтбора.Вставить("ДатаРеестраДебиторов",Дата(1,1,1));
	ПараметрыОтбора.Вставить("НаборВидовРасчета",НаборВидовРасчета);
	ПараметрыОтбора.Вставить("ТипДокумента",Перечисления.рцТипыОперацийПодачаИска.СудебныйПриказ);
	ПараметрыОтбора.Вставить("НачалоПериода",НачалоПериода);
	ПараметрыОтбора.Вставить("КонецПериода",КонецПериода);
	ПараметрыОтбора.Вставить("СрокЗадолженности",0);
	ПараметрыОтбора.Вставить("СуммаОсновногоДолга",0);
	ПараметрыОтбора.Вставить("ТарифСудебныхРасходов",0);
	ПараметрыОтбора.Вставить("УК",УК);
	
	// Использовать ежемесячное начисления пени
	ПараметрыОтбора.Вставить("НаборВидовРасчетаПени", Неопределено);
	ПараметрыОтбора.Вставить("ИспользоватьНачисленнуюПеню", Ложь);
	
	ПараметрыОтбора.Вставить("ЛицевыеСчета",ЛицевойСчет);	
	Состав = Неопределено;
	рцПИРаботаСервер.ЗаполнитьСоставДолжниковПоПараметрамОтбора(Состав,ПараметрыОтбора);
	
	ТабДок_ДляАнализа = Новый ТабличныйДокумент;
	ВыводПрямогоРезультатвТД(Состав, ТабДок_ДляАнализа);
	СравнитьРезультатВыполненияТестаСЭталоном("ТестДолжен_ПроверитьРасчет_Пени_00000000000084360", ТабДок_ДляАнализа);
	
КонецПроцедуры

#КонецОбласти


#Область ОбщиеПроцедуры

Процедура СравнитьРезультатВыполненияТестаСЭталоном(пИмяЭталона, РезультатОтчета)
	
	// Получение эталонного отчета
	// Важно эталон получать именно так из-за плясок с кодом языка макета
	МакетЭталона = ПолучитьМакет(пИмяЭталона);
	Эталон = Новый ТабличныйДокумент;
	Эталон.Вывести(МакетЭталона);	
	
	#Если ТолстыйКлиентОбычноеПриложение или ТолстыйКлиентУправляемоеПриложение Тогда

		// Сохранение в файлы mxl
		ИмяФайлаЭталона = ПолучитьИмяВременногоФайла("mxl");
		ИмяФайлаРезультатаОтчета = ПолучитьИмяВременногоФайла("mxl");
		Эталон.Записать(ИмяФайлаЭталона);
		РезультатОтчета.Записать(ИмяФайлаРезультатаОтчета);
			
		// Сравнение файлов
		
		// Если Истина, то будет показано окно демонстрации различий, если файлы различны
		// Использовать только для расследования ошибки, если тест падает на сравнении
		ПоказатьРазличия = Истина;
		
		// ПараметрыСравнения заполняется по необходимости. Если не заполнены, то используются значения по умолчанию платформы
		// Если не указан способ сравнения, будет попытка определить автоматически по расширению файла:
		//  mxl - ТабличныйДокумент
		//  txt,xml - ТекстовыйДокумент
		ПараметрыСравнения = Новый Структура;
		//ПараметрыСравнения.Вставить("ИгнорироватьПустоеПространство", Истина);
		//ПараметрыСравнения.Вставить("УчитыватьРазделителиСтрок", Ложь);
		//ПараметрыСравнения.Вставить("УчитыватьРегистр", Ложь);
		//ПараметрыСравнения.Вставить("СпособСравнения", СпособСравненияФайлов.ТекстовыйДокумент);
		
		Утверждения.ПроверитьРавенствоФайлов(ИмяФайлаЭталона, ИмяФайлаРезультатаОтчета,
			"Ожидали, что результат отчета соответствует эталону", ПараметрыСравнения, ПоказатьРазличия);
	#Иначе
		УтвержденияПроверкаТаблиц.ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям(Эталон, РезультатОтчета, "Ожидали, что эталон (слева) совпадет с результатом (справа), а они различны!");
			
	#КонецЕсли	

КонецПроцедуры

Процедура ВыводДЗвТД(Результат, ТД) Экспорт

	//Вывод результа
	ОбластьВывода=ТД.ПолучитьОбласть(1,1,1,Результат.Колонки.Количество());
	Для Счетчик=1 по Результат.Колонки.Количество() Цикл
		ОбластьЗаполнения=ОбластьВывода.Область(1,Счетчик,1,Счетчик);
		ОбластьЗаполнения.Параметр=Результат.Колонки[Счетчик-1].Имя;
		ОбластьЗаполнения.Заполнение=ТипЗаполненияОбластиТабличногоДокумента.Параметр;
	КонецЦикла;

	СтрокиПоЗадолженности = Результат.Строки;
	
	ОбщиеИтоги = СтрокиПоЗадолженности[0];
	ОбластьВывода.Параметры.Заполнить(ОбщиеИтоги);
	ТД.Вывести(ОбластьВывода);
	
	Для каждого ИтогиЗаГод Из ОбщиеИтоги.Строки Цикл
		ОбластьВывода.Параметры.Заполнить(ИтогиЗаГод);
		ТД.Вывести(ОбластьВывода);
		Для каждого ДетальнаяСтрока Из ИтогиЗаГод.Строки Цикл
			ОбластьВывода.Параметры.Заполнить(ДетальнаяСтрока);
			ТД.Вывести(ОбластьВывода);
		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

Процедура ВыводПрямогоРезультатвТД(Результат, ТД) Экспорт

	ТЗ_Пени = Результат[0].Пени;
	ТЗ_ГП = Результат[0].Госпошлина;
	Колонки_Пени = ТЗ_Пени.Колонки;
	Колонки_Пени.Добавить("СуммаГоспошлины", Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(15,2)));
	
	//Вывод результа
	ОбластьВывода=ТД.ПолучитьОбласть(1,1,1,ТЗ_Пени.Колонки.Количество());
	Для Счетчик=1 по ТЗ_Пени.Колонки.Количество() Цикл
		ОбластьЗаполнения=ОбластьВывода.Область(1,Счетчик,1,Счетчик);
		ОбластьЗаполнения.Параметр=ТЗ_Пени.Колонки[Счетчик-1].Имя;
		ОбластьЗаполнения.Заполнение=ТипЗаполненияОбластиТабличногоДокумента.Параметр;
	КонецЦикла;
	
	//Выводим данные по ГП
	Для каждого ТекСтрока Из ТЗ_ГП Цикл
		ОбластьВывода.Параметры.Заполнить(ТекСтрока);
		ТД.Вывести(ОбластьВывода);
	КонецЦикла;
	
	//Выводим данные по Пене
	Для каждого ТекСтрока Из ТЗ_Пени Цикл
		ОбластьВывода.Параметры.Заполнить(ТекСтрока);
		ТД.Вывести(ОбластьВывода);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти


