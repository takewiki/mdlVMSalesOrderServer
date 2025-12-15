
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderSelectServer()
SalesOrderSelectServer <- function(input,output,session, app_id, run_env = "PRD") {
  # 获取所有字段名
  SalesOrder_all_columns <- c(
    'Sales OrderID',
    'Delivery Location',
    'PN',
    'Product Name',
    'Serial Number',
    'Sales OrderQty',
    'Production Date',
    'Sales OrderID2',
    'Delivery Date',
    'Total DeliveryQty'
  )

  #设置默认值
  SalesOrder_default_columns <- c(
    'Sales OrderID',
    'Delivery Location',
    'PN',
    'Product Name',
    'Serial Number'
  )
  SalesOrder_reset_columns <- c(
    'Sales OrderID',
    'Serial Number'
  )

  # 全选按钮
  observeEvent(input$btn_SalesOrder_select_all, {
    updatePickerInput(
      session = session,
      inputId = "SalesOrder_column_selector",
      selected = SalesOrder_all_columns
    )
  })

  # 取消全选按钮
  observeEvent(input$btn_SalesOrder_deselect_all, {
    updatePickerInput(
      session = session,
      inputId = "SalesOrder_column_selector",
      selected = SalesOrder_reset_columns
    )
  })
  # 默认值按钮
  observeEvent(input$btn_SalesOrder_defaultValue, {
    updatePickerInput(
      session = session,
      inputId = "SalesOrder_column_selector",
      selected = SalesOrder_default_columns
    )
  })
  #获取参数
  text_SalesOrder=tsui::var_text('text_SalesOrder')
  #查询按钮
  # 显示选择信息
  output$SalesOrder_selection_info <- renderPrint({
    selected <- input$SalesOrder_column_selector
    cat("Column Count: ", length(selected), "\n")
    cat("Column List: ", paste(selected, collapse = ", "), "\n")
    FOrderNumber=text_SalesOrder()
    cat("Sales Order Number:",FOrderNumber)
  })



  #查询按钮

  shiny::observeEvent(input$btn_SalesOrder_view,{

    FSalesOrderID=text_SalesOrder()


    if(FSalesOrderID==''){

      tsui::pop_notice("Please Enter Sales Order")


    }else{
      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)
      data = mdlVMSalesOrderPkg::SalesOrder_select(erp_token =erp_token ,FSalesOrderID =FSalesOrderID )
      data_selected = data[ ,input$SalesOrder_column_selector,drop=FALSE]
      # 增加对英文界面展示的支持
      tsui::run_dataTable2(id ='SalesOrder_resultView' ,data =data_selected,lang='en')

      tsui::run_download_xlsx(id = 'dl_SalesOrder',data = data_selected,filename = 'SalesOrder.xlsx')


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderServer()
SalesOrderServer <- function(input,output,session, app_id, run_env = "PRD") {
  SalesOrderSelectServer(input = input,output = output,session = session,app_id=app_id, run_env = run_env)


}
