with 
_xml(raw_xml) as
(
	select
	'
	<SystemConfiguration Model="Test01">
	
	<Component Name="Test 001">
	 <Attribute Name="TestAttribute001">attribute element value
001</Attribute>
	 <Attribute Name="TestAttribute002">attribute element value
002</Attribute>
	 <!--  <Attribute Name="Test Comment 001">Testing comment
001</Attribute>-->	 
	 <!--  <Attribute Name="Test Comment 002">Testing comment
002</Attribute>-->
	 <!--  <Attribute Name="Test Comment 002">Testing comment
003</Attribute>-->
	 <Attribute Name="TestAttribute003">attribute element value
003</Attribute>
	</Component>
	</SystemConfiguration>
	'::xml
),
_components(name, attribute_xml, comment_xml) as
(
	select 
		root_components.fqdd,
		root_components.attribute_xml,
		root_components.comments
	from
		_xml,			
		xmltable
		(
			'//SystemConfiguration/Component'
			passing raw_xml
			columns
				fqdd text path '@Name',
				attribute_xml xml path 'Attribute/self::node()',
				comments xml path 'comment()'
		) as root_components
	
	
)
select * from _components
