<?php 
class LocationForm extends EasyForm
{
	
	public function close(){
		$parentForm = BizSystem::getObject($this->m_ParentFormName);
		$parentForm->rerender();
		return parent::close();
	}
	
	public function outputAttrs()
	{
		$result = parent::outputAttrs();
		$result['js_name'] = str_replace(".", "_", $result['name']);
		$result['js_name'] = md5($result['js_name']);
		return $result;
	}

}
?>