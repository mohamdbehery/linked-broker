app.controller("customersCtrl", function ($scope, $http, customersServices) {
   
    $scope.Customers = new kendo.data.DataSource({
        pageSize: 25,
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
        sort: { field: 'CompanyID', dir: 'desc' },
        transport: {
            read: function (e) {
                $http.post('/api/GetCustomers', e.data).
                success(function (data) {
                    e.success(data)
                }).
                error(function (data, status, headers, config) {
                    alert('يوجد خطأ فى جلب البيانات أرجو اعادة تحميل الصفحة')
                    console.log(status);
                });
            }
        },
        schema: { data: "data", total: "total" }
    });
    $scope.kendoGridOptions = {
        sortable: true,
        selectable: true,
        scrollable: true,
        height: 540,
        filterable: {
            messages: {
                info: "قائمة الحث", // sets the text on top of the Filter menu
                filter: "بحث", // sets the text for the "Filter" button
                clear: "مسح", // sets the text for the "Clear" button

                // when filtering boolean numbers
                isTrue: "custom is true", // sets the text for "isTrue" radio button
                isFalse: "custom is false", // sets the text for "isFalse" radio button

                //changes the text of the "And" and "Or" of the Filter menu
                and: "CustomAnd",
                or: "CustomOr"
            },
            operators: {
                //filter menu for "string" type columns
                string: {
                    eq: "يساوى",
                    neq: "لا يساوى",
                    startswith: "يبدأ ب",
                    contains: "يحتوى على",
                    endswith: "ينتهى ب"
                },
                //filter menu for "number" type columns
                number: {
                    eq: "Custom Equal to",
                    neq: "Custom Not equal to",
                    gte: "Custom Is greater than or equal to",
                    gt: "Custom Is greater than",
                    lte: "Custom Is less than or equal to",
                    lt: "Custom Is less than"
                },
                //filter menu for "date" type columns
                date: {
                    eq: "Custom Equal to",
                    neq: "Custom Not equal to",
                    gte: "Custom Is after or equal to",
                    gt: "Custom Is after",
                    lte: "Custom Is before or equal to",
                    lt: "Custom Is before"
                },
                //filter menu for foreign key values
                enums: {
                    eq: "custom Is Equal to",
                    neq: "custom Is Not equal to"
                }
            }
        },
        pageable: {
            messages: {
                display:"عرض {0} - {1} عنصر من {2}",
                empty: "لا يوجد بيانات يتم عرضها",
                page: "صفحة",
                allPages: "كل الصفحات",
                of: "من {0}", //{0} is total amount of pages
                itemsPerPage: "عنصر فى الصفحة",
                first: "الذهاب الى أول صفحة",
                previous: "الذهاب الى الصفحة السابقة",
                next: "الذهاب الى الصفحة التالية",
                last: "الذهاب الى اخر صفحة",
                refresh: "تحديث"
            },
            pageSizes: [5, 15, 25, 50, 100]
        },
        dataSource: $scope.Customers,
        columns: [
            { command: [{ template: "<div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>الحدث <span class='caret'></span></button><ul class='dropdown-menu'><li class='text-right'><a href='/Customers/Edit/{{dataItem.CustomerID}}'>تعديل</a></li><li class='text-right'><li role='separator' class='divider'></li><li class='text-right'><a href='' ng-click='DeleteAdv(dataItem)'>حذف</a></li></ul></div>" }], width: 100, locked: true },
            { field: "CustomerID", title: "الكود", width: 80, sortable: false, filterable: { extra: false },locked:true },
            { field: "CustomerName", title: "اسم العميل", width: 100, sortable: false, filterable: { extra: false } },
            { field: "CreatedDate", title: "تاريخ ", width: 100, sortable: false, template: "#= kendo.toString(kendo.parseDate(CreatedDate), 'yyyy-MM-dd') #", filterable: false },
            { field: "CustomerStatusTitle", title: "حالة العميل", width: 150, sortable: false, filterable: { ui: statusFilter, extra: false} },
        ]
    };

    function statusFilter(element) {
        element.kendoDropDownList({
            dataSource: {
                transport: {
                    read: "/api/CustomerStatus"
                }
            },
            dataTextField: "CustomerStatusTitle",
            dataValueField: "CustomerStatusID",
            optionLabel: "--إختار الحالة--"
        });
    }

    $scope.DeleteAdv = function (row) {
        if (confirm("تحذير ! سوف يتم الحذف هل انت متأكد ؟")) {
            var raw = $scope.Customers.data();
            customersServices.DeleteCustomer(row.CustomerID).success(function (data) {
                raw.remove(row);
            });
        }
    };
});