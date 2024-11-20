SELECT unnest(xpath('/name/text()', xmlelement(name name, 'AT&T', null )))
