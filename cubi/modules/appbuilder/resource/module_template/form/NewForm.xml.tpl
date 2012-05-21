<?xml version="1.0" encoding="UTF-8"?>
<EasyForm Name="{$form_name}" 
			Class="{$form_class}" 
			FormType="New" 
			jsClass="Openbiz.Form" 
			Icon="{$form_icon}"
			Title="{$form_title}" 
			Description="{$form_description}" 
			BizDataObj="{$form_do}" 
			TemplateEngine="Smarty" 
			TemplateFile="{$form_template}" 
			MessageFile="{$message_file}" 
			Access="{$acl.create}">
    <DataPanel>
{foreach from=$fields item=fld}
{if $fld.Field != 'Id' && 
	$fld.Field != 'id' && 
	$fld.Field != 'type_id' && 
	$fld.Field != 'create_by' &&	
	$fld.Field != 'create_time' && 
	$fld.Field != 'update_by' && 
	$fld.Field != 'update_time' && 
	$fld.Field != 'other_perm' && 
	$fld.Field != 'group_perm' &&
	$fld.Field != 'group_id' &&
	$fld.Field != 'owner_id' &&
	$fld.Field != 'sortorder' &&
	$fld.Field != 'sort_order' &&
	$fld.Field != 'type_name' &&
	$fld.Field != 'type_color'  &&
	$fld.Field != 'description'  &&
	$fld.Field != 'content'  &&
	$fld.Field != 'desc'  
	}
       	<Element Name="fld_{$fld.Field}" 
       				ElementSet="General" 
       				Class="InputText" 
       				FieldName="{$fld.Field}" 
       				Label="{$fld.FieldLabel}" 
       				AllowURLParam="{if $fld.Field eq 'Id'}Y{else}N{/if}"/>
{elseif $fld.Field == 'type_id' }
       	<Element Name="fld_type_id" 
       				Class="common.lib.TypeSelector" 
       				FieldName="type_id" 
       				Label="Type" 
       				KeepCookie="Y" 
       				SelectFrom="{$form_type_do}[name:Id:color]" 
       				AllowURLParam="N" />       
{/if}       								   	

{if $fld.Field == 'description' ||
	$fld.Field == 'content' ||
	$fld.Field == 'desc' }       	 	
		<Element Name="fld_{$fld.Field}" 
					Class="Textarea" 
					ElementSet="General" 
					FieldName="{$fld.Field}" 
					Label="{$fld.FieldLabel}"  />		
{/if}
{if $fld.Field == 'sortorder' ||
	$fld.Field == 'sort_order'  }       	 	
		<Element Name="fld_{$fld.Field}" 
					Class="Listbox" 
					ElementSet="Miscellaneous" 
					SelectFrom="common.lov.CommLOV(Order)" 
					DefaultValue="50" 
					FieldName="{$fld.Field}" 
					Label="Sorting"  />		
{/if}

{/foreach}
{if $do_perm_control eq 'Y'  }  
		<Element Name="fld_published" 
					Class="Listbox" 
					ElementSet="Miscellaneous" 
					KeepCookie="Y" 
					SelectFrom="common.lov.CommLOV(Published)" 
					DefaultValue="1" 
					FieldName="group_perm" 
					Label="Group Share"  />
		<Element Name="fld_published_other" 
					Class="Listbox" 
					ElementSet="Miscellaneous" 
					KeepCookie="Y" 
					SelectFrom="common.lov.CommLOV(Published)" 
					DefaultValue="0" 
					FieldName="other_perm" 
					Label="Other Group"  />
{/if}
    </DataPanel>
    <ActionPanel>       
        <Element Name="btn_save" 
        			Class="Button" 
        			Text="Save" 
        			CssClass="button_gray_m">
            <EventHandler Name="save_onclick" 
            			EventLogMsg="" 
            			Event="onclick" 
            			Function="InsertRecord()" 
            			RedirectPage="{literal}{APP_INDEX}{/literal}/{$detail_view_url}/{literal}{{/literal}@{$form_do}:Field[Id].Value{literal}}{/literal}"  
            			ShortcutKey="Ctrl+Enter" 
            			ContextMenu="Save" />
        </Element>
        <Element Name="btn_cancel" 
        			Class="Button" 
        			Text="Cancel" 
        			CssClass="button_gray_m">
            <EventHandler Name="cancel_onclick" 
            			Event="onclick" 
            			Function="SwitchForm()"  
            			ShortcutKey="Escape" 
            			ContextMenu="Cancel"/>
        </Element>      
    </ActionPanel> 
    <NavPanel>
    </NavPanel> 
    <SearchPanel>
    </SearchPanel>
</EasyForm>