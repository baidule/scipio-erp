<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#include "catalogcommon.ftl">

<#assign productCategoryLink = requestAttributes.productCategoryLink!/>
<#if productCategoryLink?has_content>
<#if productCategoryLink.detailSubScreen?has_content>
    <@render resource=productCategoryLink.detailSubScreen />
<#else>
    <#assign titleText = productCategoryLink.titleText!/>
    <#assign imageUrl = productCategoryLink.imageUrl!/>
    <#assign detailText = productCategoryLink.detailText!/>

    <#if productCategoryLink.linkTypeEnumId == "PCLT_SEARCH_PARAM">
      <#assign linkUrl = requestAttributes._REQUEST_HANDLER_.makeLink(request, response, "keywordsearch?" + productCategoryLink.linkInfo)/>
    <#elseif productCategoryLink.linkTypeEnumId == "PCLT_ABS_URL">
      <#assign linkUrl = productCategoryLink.linkInfo!/>
    <#elseif productCategoryLink.linkTypeEnumId == "PCLT_CAT_ID">
      <#assign linkUrl = requestAttributes._REQUEST_HANDLER_.makeLink(request, response, "category/~category_id=" + productCategoryLink.linkInfo) + "/~pcategory=" + productCategoryId/>
      <#assign linkProductCategory = delegator.findOne("ProductCategory", {"productCategoryId":productCategoryLink.linkInfo}, true)/>
      <#assign linkCategoryContentWrapper = Static["org.ofbiz.product.category.CategoryContentWrapper"].makeCategoryContentWrapper(linkProductCategory, request)/>
      <#assign titleText = productCategoryLink.titleText!(linkCategoryContentWrapper.get("CATEGORY_NAME"))!/>
      <#assign imageUrl = productCategoryLink.imageUrl!(linkCategoryContentWrapper.get("CATEGORY_IMAGE_URL", "url"))!/>
      <#assign detailText = productCategoryLink.detailText!(linkCategoryContentWrapper.get("DESCRIPTION"))!/>
    </#if>

    <div class="productcategorylink">
      <#if imageUrl?string?has_content>
        <div class="smallimage"><a href="${linkUrl}"><img src="<@ofbizContentUrl>${imageUrl}</@ofbizContentUrl>" alt="${titleText!"Link Image"}"/></a></div>
      </#if>
      <#if titleText?has_content>
        <a href="${linkUrl}" class="${styles.link_nav_info_name!}">${titleText}</a>
      </#if>
      <#if detailText?has_content>
        <div>${detailText}</div>
      </#if>
    </div>
</#if>
</#if>
