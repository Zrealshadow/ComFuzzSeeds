select xmlserialize(document xmlroot(xmlelement(name "ЭлементВКириллице",
xmlattributes('ЗначениеВКириллице' as "АтрибутВКириллице"),
'ТекстВКириллице'), version '1.0', standalone yes) as text);
