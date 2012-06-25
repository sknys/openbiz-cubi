<?php

/**
 * Openbiz Cubi Application Platform
 *
 * LICENSE http://code.google.com/p/openbiz-cubi/wiki/CubiLicense
 *
 * @package   cubi.service
 * @copyright Copyright (c) 2005-2011, Openbiz Technology LLC
 * @license   http://code.google.com/p/openbiz-cubi/wiki/CubiLicense
 * @link      http://code.google.com/p/openbiz-cubi/
 * @version   $Id$
 */

/**
 * Service for general utilities 
 */
class utilService
{

    /**
     * Format size number to near unit of B, KB, Mb, GB and TB
     * @param int $size
     * @return string  
     */
    public static function format_bytes($size)
    {
        $units = array(' B', ' KB', ' MB', ' GB', ' TB');
        for ($i = 0; $size >= 1024 && $i < 4; $i++)
            $size /= 1024;
        return round($size, 2) . $units[$i];
    }

    /**
     * Get view URL from view name
     * 
     * @param string $viewName
     * @return string 
     */
    public static function getViewURL($viewName)
    {
        $urlArr = explode(".", $viewName);
        $view = str_replace("View", "", $urlArr[2]);
        preg_match_all("/([A-Z]{1}[a-z]+)/s", $view, $match);
        foreach ($match[0] as $viewPart)
        {
            $viewUrl .= strtolower($viewPart) . '_';
        }
        $viewUrl = substr($viewUrl, 0, strlen($viewUrl) - 1);
        $url = $urlArr[0] . '/' . $viewUrl;
        return $url;
    }

}
