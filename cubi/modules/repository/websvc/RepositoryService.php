<?php
include_once MODULE_PATH.'/websvc/lib/WebsvcService.php';
class RepositoryService extends WebsvcService
{
	protected $m_CategoryDO 		= "repository.category.do.CategoryDO";
	protected $m_ApplicationDO 		= "repository.application.do.ApplicationDO";
	protected $m_ReleaseDO 			= "repository.release.do.ReleaseDO";
	protected $m_PictureDO	 		= "picture.do.PictureDO";
	protected $m_RepositorySettingDO= "myaccount.do.PreferenceDO";
	
    public function fetchRepoInfo()
    {
    	$searchRule = "[user_id]='0' AND [name] LIKE 'repo_%'";   
    	$dataObj = BizSystem::getObject($this->m_RepositorySettingDO);    	
        $resultRecords = $dataObj->directfetch($searchRule);
        $prefRecord = array();
        foreach($resultRecords as $record){
        	$prefRecord["_".$record['name']] = $record["value"];
        }
        return $prefRecord;
    }
    
    
    public function fetchAppInfo($id=null)
    {
    	$searchRule = "[status]=1 AND [release_time] < NOW() AND [Id]='$id'";   	    	
    	$dataObj = BizSystem::getObject($this->m_ApplicationDO,1);  
        $result = $dataObj->fetchOne($searchRule);  
        if($result)
        {
        	$result = $result->toArray();
        }
        else
        {
        	$result = array();
        }
        return $result;
    } 

    public function fetchAppPics($id=null)
    {
    	$searchRule = "[type]='application' AND [foreign_id]='$id'";   	    	
    	$dataObj = BizSystem::getObject($this->m_PictureDO,1);  
    	$resultRecords = $dataObj->directfetch($searchRule);  
        $resultSet = array();
       	foreach($resultRecords as $record)
       	{
       		$resultSet[] = $record;
       	}
        return $resultSet;
    }     

    public function fetchAppLatestRelease($id=null)
    {
    	$searchRule = "[app_id]='$id'"; 
    	$sortRule = "[Id] DESC";  	    	
    	$dataObj = BizSystem::getObject($this->m_ReleaseDO,1);  
    	$results = $dataObj->directfetch($searchRule,null,null,$sortRule);  
    	if($results)
        {
        	$result = $results[0];
        }
        else
        {
        	$result = array();
        }
        return $result;
    }      
    
    public function fetchFeaturedApps($param=array())
    {
    	$searchRule = "[status]=1 AND [release_time] < NOW() AND [featured]=1";
    	$sortRule 	= $param['sortRule'];
    	$userSearchRule = $param['searchRule'];
    	$startItem 	= $param['startItem'];
    	$range 	= $param['range'];
    	if($userSearchRule){
    		$searchRule .= " AND ".$userSearchRule;
    	}    	    	
    	$dataObj = BizSystem::getObject($this->m_ApplicationDO,1);  
    	$dataObj->setSearchRule($searchRule);
    	$dataObj->setSortRule($sortRule);
    	$dataObj->setLimit($range, $startItem);  
        $resultRecords = $dataObj->fetch();  
        $resultSet = array();
       	foreach($resultRecords as $record)
       	{
       		$resultSet[] = $record;
       	}
       	$result['data'] = $resultSet;
       	$result['totalRecords'] = $dataObj->count();
        return $result;
    }    

    public function fetchApplications($cat_id = null,$param=array())
    {
    	$searchRule = "[status]=1 AND [release_time] < NOW() ";
    	if($cat_id){
    		$searchRule .= " AND [cat_id]=$cat_id ";
    	}
    	$sortRule 	= $param['sortRule'];
    	$userSearchRule = $param['searchRule'];
    	$startItem 	= $param['startItem'];
    	$range 	= $param['range'];
    	if($userSearchRule){
    		$searchRule .= " AND ".$userSearchRule;
    	}    	
    	$dataObj = BizSystem::getObject($this->m_ApplicationDO,1);  
    	$dataObj->setSearchRule($searchRule);
    	$dataObj->setSortRule($sortRule);
    	$dataObj->setLimit($range, $startItem);  
        $resultRecords = $dataObj->fetch();  
        $resultSet = array();
       	foreach($resultRecords as $record)
       	{
       		$resultSet[] = $record;
       	}
       	$result['data'] = $resultSet;
       	$result['totalRecords'] = $dataObj->count();
        return $result;
    }        

    public function fetchCategories()
    {
    	$searchRule = "[publish]=1";    	
    	$dataObj = BizSystem::getObject($this->m_CategoryDO,1);    	   
        $resultRecords = $dataObj->directfetch($searchRule);  
        $resultSet = array();        
       	foreach($resultRecords as $record)
       	{
       		$resultSet[] = $record;
       	}
        return $resultSet;
    }        
    
}
?>