var ddlArea = "#LocationID";

$(document).ready(function () {
    $("#ddlGovernorateID").append("<option value='0'>اختر</option>");
    $("#ddlCityID").append("<option value='0'>اختر</option>");
    
    if ($(ddlArea).length == 0) {
        ddlArea = "#LocationIDs";
        if ($(ddlArea).length == 0)
            ddlArea = "#rID";
    }

    if ($("#btnAddProperty").length > 0) {
        $("#ProjectID").on('change', HandleLocationsForProperty);
        HandleLocationsForProperty();
        $("#btnAddProperty").on('click', ValidateLocationWhileAddingProperty);
        ddlArea = "#ddlLocations";
        $('#LocationID').val($("#txtHiddenLocation").val());
        $(ddlArea).on('change', function () {
            $('#LocationID').val($(ddlArea).val());
        });

    }
    else {
        $(ddlArea).append("<option value=''>اختر</option>");
        LoadGovernorates();
    }

    $("#ddlGovernorateID").on('change', LoadCities);
    $("#ddlCityID").on('change', LoadAreas);

    HandleLocationType();
    $("#btnAddRequest").on('click', ValidateAddingRequest);
    $("#btnAddCompany").on('click', ValidateAddingCompany);
    $("#btnAddProject").on('click', ValidateAddingProject);
});

var AreaID = 0;
var CityID = 0;
AreaID = $("#txtHiddenLocation").val();
var IsAddingRequest = false;

var HandleLocationsForProperty = function () {
    var ProjectID = $("#ProjectID").val();
    if (parseInt(ProjectID) > 0) {
        $.get("/api/GetProjectLocation/" + ProjectID, function (LocationID) {
            AreaID = LocationID;
            $('#LocationID').val(LocationID);
            IsAddingRequest = true;
            LoadGovernorates();
        });
    }
    else
    {
        IsAddingRequest = false;
        $('#ddlGovernorateID').prop('disabled', IsAddingRequest);
        $('#ddlCityID').prop('disabled', IsAddingRequest);
        $(ddlArea).prop('disabled', IsAddingRequest);
        $(ddlArea).val(0);
        LoadGovernorates();
    }
}

var HandleLocationType = function () {
    $("#pLocationError").text('');
    if ($("input:radio[name='chbLocationType']").length == 3) {
        if (AreaID > 0) { // edit mode
            $("input:radio[name='chbLocationType']").attr('disabled', true);
            $.get("/api/GetAreaLocations/" + AreaID, function (locations) {
                if (locations.CityID && locations.GovID) {
                    $("input[name=chbLocationType][value=area]").attr('checked', 'checked');
                }
                else if (!locations.GovID && locations.CityID) {
                    $("input[name=chbLocationType][value=city]").attr('checked', 'checked');
                }
                else if (!locations.GovID && !locations.CityID) {
                    $("input[name=chbLocationType][value=gov]").attr('checked', 'checked');
                }
            });
        }
        $("input:radio[name='chbLocationType']").on('change', LocationType_Changed);
        $("#btnLocationSubmit").on('click', ValidateLocation);
    }
}

var ValidateAddingRequest = function () {

    $("[data-valmsg-for=Title]").text('');

    var errors = 0;
    var errorElement = '';

    if (!$('#Title').val()) {
        $("[data-valmsg-for=Title]").text('من فضلك ادخل عنوان الطلب');
        errors += 1;
        errorElement = errorElement ? errorElement : 'Title';
    }

    if (errors > 0) {
        ScrollToElement(errorElement);
        return false;
    }

    return true;
}

var ValidateAddingCompany = function () {

    $("[data-valmsg-for=CompanyName]").text('');
    $("[data-valmsg-for=CompanyDesc]").text('');

    var errors = 0;
    var errorElement = '';

    if (!$('#CompanyName').val()) {
        $("[data-valmsg-for=CompanyName]").text('من فضلك ادخل اسم الشركة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'CompanyName';
    }

    if (!$('#CompanyDesc').val()) {
        $("[data-valmsg-for=CompanyDesc]").text('من فضلك ادخل نبذه عن الشركة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'CompanyDesc';
    }

    if (errors > 0) {
        ScrollToElement(errorElement);
        return false;
    }

    return true;
}

var ValidateAddingProject = function () {

    $("[data-valmsg-for=ProjectName]").text('');
    $("[data-valmsg-for=AddressDetails]").text('');

    $("[data-valmsg-for=ddlGovernorateID]").text('');
    $("[data-valmsg-for=ddlCityID]").text('');
    $("[data-valmsg-for=LocationID]").text('');

    var errors = 0;
    var errorElement = '';

    if (!$('#ProjectName').val()) {
        $("[data-valmsg-for=ProjectName]").text('من فضلك ادخل اسم المشروع');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ProjectName';
    }

    if (!$('#AddressDetails').val()) {
        $("[data-valmsg-for=AddressDetails]").text('من فضلك ادخل العنوان');
        errors += 1;
        errorElement = errorElement ? errorElement : 'AddressDetails';
    }

    if ($('#ddlGovernorateID').val() == '0') {
        $("[data-valmsg-for=ddlGovernorateID]").text('من فضلك اختر المحافظة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ddlGovernorateID';
    }

    if ($('#ddlCityID').val() == '0') {
        $("[data-valmsg-for=ddlCityID]").text('من فضلك اختر المدينة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ddlCityID';
    }

    if ($('#LocationID').val() == '0') {
        $("[data-valmsg-for=LocationID]").text('من فضلك اختر المنطقة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'LocationID';
    }

    if (errors > 0) {
        ScrollToElement(errorElement);
        return false;
    }

    return true;
}

var ValidateLocationWhileAddingProperty = function () {

    $("[data-valmsg-for=ddlGovernorateID]").text('');
    $("[data-valmsg-for=ddlCityID]").text('');
    $("[data-valmsg-for=ddlLocations]").text('');

    var errors = 0;
    var errorElement = '';

    if ($('#ddlGovernorateID').val() == '0') {
        $("[data-valmsg-for=ddlGovernorateID]").text('من فضلك اختر المحافظة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ddlGovernorateID';
    }

    if ($('#ddlCityID').val() == '0') {
        $("[data-valmsg-for=ddlCityID]").text('من فضلك اختر المدينة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ddlCityID';
    }

    if ($('#ddlLocations').val() == '0') {
        $("[data-valmsg-for=ddlLocations]").text('من فضلك اختر المنطقة');
        errors += 1;
        errorElement = errorElement ? errorElement : 'ddlLocations';
    }

    if (errors > 0) {
        ScrollToElement(errorElement);
        return false;
    }

    return true;
}

var ScrollToElement = function (ElementID) {
    var elementOffset = $('#' + ElementID).offset().top;
    var windowHeight = $(window).height();
    $(window).scrollTop(elementOffset - (windowHeight / 2));
    $('html, body').animate({
        scrollTop: elementOffset - (windowHeight / 2)
    }, 'slow');
}

var ValidateLocation = function () {
    var ParentID = null;
    var Type = $("input:radio[name='chbLocationType']:checked").val();

    if (!$('#divLocationGov').hasClass('HideElement') && $('#ddlGovernorateID').val() == '0') {
        $("#pLocationError").text('من فضلك اختر المحافظة');
        return false;
    }

    if (!$('#divLocationCity').hasClass('HideElement') && $('#ddlCityID').val() == '0') {
        $("#pLocationError").text('من فضلك اختر المدينة');
        return false;
    }

    if (!$('#LocationName').val()) {
        $("#pLocationError").text('من فضلك اختر المنطقة');
        return false;
    }

    $("#pLocationError").text('');
    if (!$('#divLocationCity').hasClass('HideElement') && $('#ddlCityID').val() > 0)
        ParentID = $('#ddlCityID').val();
    else if (!$('#divLocationGov').hasClass('HideElement') && $('#ddlGovernorateID').val() > 0)
        ParentID = $('#ddlGovernorateID').val();


    $('#ParentID').val(ParentID);
    return true;
}

var LocationType_Changed = function () {
    var Type = $("input:radio[name='chbLocationType']:checked").val();
    if (Type == 'gov') {
        $('#divLocationGov').addClass('HideElement');
        $('#divLocationCity').addClass('HideElement');
    }
    else if (Type == 'city') {
        $('#divLocationGov').removeClass('HideElement');
        $('#divLocationCity').addClass('HideElement');
    }
    else {
        $('#divLocationGov').removeClass('HideElement');
        $('#divLocationCity').removeClass('HideElement');
    }
}

var LoadGovernorates = function () {
    $("#ddlGovernorateID").find('option').remove().end();
    $("#ddlGovernorateID").append("<option value='0'>اختر</option>");
    $("#ddlCityID").find('option').remove().end();
    $("#ddlCityID").append("<option value='0'>اختر</option>");
    $("#ddlCityID").val(0);
    GetLocations(0, "ddlGovernorateID", function () {
        if (AreaID > 0) {
            $.get("/api/GetAreaLocations/" + AreaID, function (locations) {
                CityID = locations.CityID;
                if ($('#ddlGovernorateID option[value=' + locations.GovID + ']').length > 0) {
                    $('#ddlGovernorateID').val(locations.GovID);
                    $('#ddlGovernorateID').prop('disabled', IsAddingRequest);
                    LoadCities();
                }
            });
        }
        if (SiteConstants.PropReqGovID) {
            $("#ddlGovernorateID").val(SiteConstants.PropReqGovID);
            LoadCities();
        }
    });
}

var LoadCities = function () {
    $("#ddlCityID").find('option').remove().end();
    $("#ddlCityID").append("<option value='0'>اختر</option>");
    $("#ddlCityID").val(0);
    $(ddlArea).find('option').remove().end();
    $(ddlArea).append("<option value='0'>اختر</option>");
    var Gov = $("#ddlGovernorateID").val();
    if (Gov > 0) {
        GetLocations(Gov, "ddlCityID", function () {
            if (CityID > 0 && $('#ddlCityID option[value=' + CityID + ']').length > 0) {
                $("#ddlCityID").val(CityID);
                $('#ddlCityID').prop('disabled', IsAddingRequest);
                LoadAreas();
            }
            if (SiteConstants.PropReqCityID) {
                $("#ddlCityID").val(SiteConstants.PropReqCityID);
                $('#ddlCityID').prop('disabled', IsAddingRequest);
                LoadAreas();
            }
        });
    }
}

var LoadAreas = function () {
    $(ddlArea).find('option').remove().end();
    $(ddlArea).append("<option value='0'>اختر</option>");
    $(ddlArea).val(0);
    var City = $("#ddlCityID").val();
    if (City > 0) {
        GetLocations(City, ddlArea.replace('#', ''), function () {
            if (CityID > 0) {
                $(ddlArea).val(AreaID);
                $(ddlArea).attr('disabled', IsAddingRequest);
                AreaID = 0;
                CityID = 0;
            }
        });
    }
}

var GetLocations = function (ParentID, ElementID, CallBack) {
    $.get("/api/Locations/" + ParentID, function (locations) {
        for (var i = 0; i < locations.length; i++) {
            $("#" + ElementID).append("<option value=\"" + locations[i].LocationID + "\">" + locations[i].LocationName + "</option>");
        }
        CallBack();
    });
}