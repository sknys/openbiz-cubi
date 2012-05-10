<?xml version="1.0" encoding="UTF-8"?>
<EasyForm Name="{$form_name}" Class="{$form_class}" FormType="List" jsClass="jbForm" Title="{$form_title}" Description="{$form_description}" BizDataObj="{$form_do}" PageSize="10" DefaultForm="Y" TemplateEngine="Smarty" TemplateFile="grid.tpl" EventName="{$event_name}" MessageFile="{$message_file}" Access="{$acl.access}">
    <DataPanel>
{assign var=col_counter value=0}            
{foreach from=$fields item=fld}
{if $fld.name == 'Id'}
        <Element Name="row_selections" Class="RowCheckbox"  Label="" FieldName="{$fld.name}"/>
        <Element Name="fld_{$fld.name}" Class="ColumnText" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" Sortable="Y" AllowURLParam="N" Link="javascript:">         
         	<EventHandler Name="fld_{$fld.name}_onclick" Event="onclick" Function="SwitchForm({$comp}.{$detail_form},{literal}{@:Elem[fld_Id].Value}{/literal})"   />
        </Element>
{elseif $fld.name == 'sort_order'}
        <Element Name="fld_{$fld.name}" Class="ColumnSorting" FieldName="{$fld.name}" Label="Ordering"  Sortable="Y" AllowURLParam="N" Translatable="N" OnEventLog="N" >
        	<EventHandler Name="fld_sortorder_up" Event="onclick" EventLogMsg="" Function="UpdateFieldValue({literal}{@:Elem[fld_Id].Value}{/literal},fld_{$fld.name},{literal}{{/literal}@:Elem[fld_{$fld.name}].Value-5{literal}}{/literal})" />
        	<EventHandler Name="fld_sortorder_down" Event="onclick" EventLogMsg="" Function="UpdateFieldValue({literal}{@:Elem[fld_Id].Value}{/literal},fld_{$fld.name},{literal}{{/literal}@:Elem[fld_{$fld.name}].Value+5{literal}}{/literal})" />
        </Element>        	
{elseif $fld.raw_type!='timestamp'  && $fld.name != 'create_by' && $fld.name != 'create_time' && $fld.name != 'update_by' && $fld.name != 'update_time' }
        {if $col_counter==1}
        <Element Name="fld_{$fld.name}" Class="ColumnText" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" {if $fld.default }DefaultValue="{$fld.default}"{/if} Sortable="Y" Link="javascript:">
         		<EventHandler Name="fld_{$fld.name}_onclick" Event="onclick" Function="SwitchForm({$comp}.{$detail_form},{literal}{@:Elem[fld_Id].Value}{/literal})"   />
        </Element>
        {else}
        <Element Name="fld_{$fld.name}" Class="ColumnText" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" {if $fld.default }DefaultValue="{$fld.default}"{/if} Sortable="Y"/>
        {/if}
        	
{/if}
{assign var=col_counter value=$col_counter+1}
{/foreach}
    </DataPanel>
    <ActionPanel>
        <Element Name="lnk_new" Class="Button" Text="Add" CssClass="button_gray_add" Description="new record (Insert)" Access="{$acl.create}">
            <EventHandler Name="lnk_new_onclick" Event="onclick" EventLogMsg="" Function="SwitchForm({$comp}.{$new_form})"  ShortcutKey="Insert" ContextMenu="New"/>
        </Element>
        <Element Name="btn_edit" Class="Button" Text="Edit" CssClass="button_gray_m" Description="edit record (Ctrl+E)" Access="{$acl.update}">
            <EventHandler Name="btn_edit_onclick" Event="onclick" EventLogMsg="" Function="EditRecord()" RedirectPage="form={$comp}.{$edit_form}&amp;fld:Id={literal}{@:Elem[fld_Id].Value}{/literal}" ShortcutKey="Ctrl+E" ContextMenu="Edit" />
        </Element>
        <Element Name="btn_copy" Class="Button" Text="Copy" CssClass="button_gray_m" Description="copy record (Ctrl+C)" Access="{$acl.create}">
            <EventHandler Name="btn_copy_onclick" Event="onclick" EventLogMsg="" Function="CopyRecord()" RedirectPage="form={$comp}.{$copy_form}&amp;fld:Id={literal}{@:Elem[fld_Id].Value}{/literal}" ShortcutKey="Ctrl+C" ContextMenu="Copy"/>
        </Element>
        <Element Name="btn_delete" Class="Button" Text="Delete" CssClass="button_gray_m" Access="{$acl.delete}">
            <EventHandler Name="del_onclick" Event="onclick" EventLogMsg="" Function="DeleteRecord()" ShortcutKey="Ctrl+Delete" ContextMenu="Delete"/>
        </Element>
        <Element Name="btn_excel" Class="Button" Text="Export" CssClass="button_gray_m">
            <EventHandler Name="exc_onclick" Event="onclick" EventLogMsg="" Function="CallService(excelService,renderCSV)" FunctionType="Popup" ShortcutKey="Ctrl+Shift+X" ContextMenu="Export"/>
        </Element>
    </ActionPanel> 
    <NavPanel>{literal}
  		<!--<Element Name="page_selector" Class="PageSelector" Text="{@:m_CurrentPage}" Label="Go to Page" CssClass="input_select" cssFocusClass="input_select_focus">
            <EventHandler Name="btn_page_selector_onchange" Event="onchange" Function="GotoSelectedPage(page_selector)"/>
        </Element>-->
        <Element Name="pagesize_selector" Class="PagesizeSelector" Text="{@:m_Range}" Label="Show Rows" CssClass="input_select" cssFocusClass="input_select_focus">
            <EventHandler Name="btn_pagesize_selector_onchange" Event="onchange" Function="SetPageSize(pagesize_selector)"/>
        </Element>      
        <Element Name="btn_first" Class="Button" Enabled="{(@:m_CurrentPage == 1)?'N':'Y'}" Text="" CssClass="button_gray_navi {(@:m_CurrentPage == 1)?'first_gray':'first'}">
            <EventHandler Name="first_onclick" Event="onclick" Function="GotoPage(1)"/>
        </Element>
        <Element Name="btn_prev" Class="Button" Enabled="{(@:m_CurrentPage == 1)?'N':'Y'}" Text="" CssClass="button_gray_navi {(@:m_CurrentPage == 1)?'prev_gray':'prev'}">
            <EventHandler Name="prev_onclick" Event="onclick" Function="GotoPage({@:m_CurrentPage - 1})" ShortcutKey="Ctrl+Shift+Left"/>
        </Element>
        <Element Name="txt_page" Class="LabelText" Text="{'@:m_CurrentPage of @:m_TotalPages '}">
        </Element>
        <Element Name="btn_next" Class="Button" Enabled="{(@:m_CurrentPage == @:m_TotalPages )?'N':'Y'}" Text="" CssClass="button_gray_navi {(@:m_CurrentPage == @:m_TotalPages)?'next_gray':'next'}">
            <EventHandler Name="next_onclick" Event="onclick" Function="GotoPage({@:m_CurrentPage + 1})" ShortcutKey="Ctrl+Shift+Right"/>
        </Element>
        <Element Name="btn_last" Class="Button" Enabled="{(@:m_CurrentPage == @:m_TotalPages )?'N':'Y'}" Text="" CssClass="button_gray_navi {(@:m_CurrentPage == @:m_TotalPages)?'last_gray':'last'}">
            <EventHandler Name="last_onclick" Event="onclick" Function="GotoPage({@:m_TotalPages})"/>
        </Element>{/literal}
    </NavPanel> 
    <SearchPanel>
    {if $searchs|@count > 0}	
	{assign var=fld value=$searchs[0] }
		<Element Name="qry_{$fld.COL_NAME}" Class="AutoSuggest" SelectFrom="{$comp}.{$do_name}[{$fld.COL_NAME}],[{$fld.COL_NAME}] like {literal}'%{@:Elem{/literal}[qry_{$fld.COL_NAME}].Value{literal}}{/literal}%' GROUP BY [{$fld.COL_NAME}]" FuzzySearch="Y" FieldName="{$fld.COL_NAME}" Label="" cssFocusClass="input_text_search_focus" CssClass="input_text_search" />
        <Element Name="btn_dosearch" Class="Button" text="Go" CssClass="button_gray">
            <EventHandler Name="search_onclick" Event="onclick" Function="RunSearch()" ShortcutKey="Enter"/>
        </Element>	
	{/if}
       
    </SearchPanel>
</EasyForm>