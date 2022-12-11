//
//  CONSTANT.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import Foundation
import UIKit


//MARK: - StoryBoard

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let adminStoryboard = UIStoryboard(name: "AdminControl", bundle: nil)

//CustomCell Identifier
let reuseCell = "customCell"
let reuseDropDown = "customCellDropdown"
let dropDownCellName = "CustomCellDropDown"
let adminReuseCell = "adminCell"
let myInboxCell = "myInboxCell"
let myRequestCell = "myRequestCell"

let concatBaseURL = ".atocash.com" //dev
var BASEURL = "https://" + (DefaultsManager.shared.baseLink ?? "") + concatBaseURL
//let concatBaseURL = ".atocashserver.ml" //POSTSQL

let nationality = ["Afghan","Albanian","Algerian","American","Andorran","Angolan","Anguillan","Argentine","Armenian","Australian","Austrian","Azerbaijani","Bahamian","Bahraini","Bangladeshi","Barbadian","Belarusian","Belgian","Belizean","Beninese","Bermudian","Bhutanese","Bolivian","Botswanan","Brazilian","British","British Virgin Islander","Bruneian","Bulgarian","Burkinan","Burmese","Burundian","Cambodian","Cameroonian","Canadian","Cape Verdean","Cayman Islander","Central African","Chadian","Chilean","Chinese","Citizen of Antigua and Barbuda","Citizen of Bosnia and Herzegovina","Citizen of Guinea-Bissau","Citizen of Kiribati","Citizen of Seychelles","Citizen of the Dominican Republic","Citizen of Vanuatu","Colombian","Comoran","Congolese (Congo)","Congolese (DRC)","Cook Islander","Costa Rican","Croatian","Cuban","Cymraes","Cymro","Cypriot","Czech","Danish","Djiboutian","Dominican","Dutch","East Timorese","Ecuadorean","Egyptian","Emirati","English","Equatorial Guinean","Eritrean","Estonian","Ethiopian","Faroese","Fijian","Filipino","Finnish","French","Gabonese","Gambian","Georgian","German","Ghanaian","Gibraltarian","Greek","Greenlandic","Grenadian","Guamanian","Guatemalan","Guinean","Guyanese","Haitian","Honduran","Hong Konger","Hungarian","Icelandic","Indian","Indonesian","Iranian","Iraqi","Irish","Israeli","Italian","Ivorian","Jamaican","Japanese","Jordanian","Kazakh","Kenyan","Kittitian","Kosovan","Kuwaiti","Kyrgyz","Lao","Latvian","Lebanese","Liberian","Libyan","Liechtenstein citizen","Lithuanian","Luxembourger","Macanese","Macedonian","Malagasy","Malawian","Malaysian","Maldivian","Malian","Maltese","Marshallese","Martiniquais","Mauritanian","Mauritian","Mexican","Micronesian","Moldovan","Monegasque","Mongolian","Montenegrin","Montserratian","Moroccan","Mosotho","Mozambican","Namibian","Nauruan","Nepalese","New Zealander","Nicaraguan","Nigerian","Nigerien","Niuean","North Korean","Northern Irish","Norwegian","Omani","Pakistani","Palauan","Palestinian","Panamanian","Papua New Guinean","Paraguayan","Peruvian","Pitcairn Islander","Polish","Portuguese","Prydeinig","Puerto Rican","Qatari","Romanian","Russian","Rwandan","Salvadorean","Sammarinese","Samoan","Sao Tomean","Saudi Arabian","Scottish","Senegalese","Serbian","Sierra Leonean","Singaporean","Slovak","Slovenian","Solomon Islander","Somali","South African","South Korean","South Sudanese","Spanish","Sri Lankan","St Helenian","St Lucian","Stateless","Sudanese","Surinamese","Swazi","Swedish","Swiss","Syrian","Taiwanese","Tajik","Tanzanian","Thai","Togolese","Tongan","Trinidadian","Tristanian","Tunisian","Turkish","Turkmen","Turks and Caicos Islander","Tuvaluan","Ugandan","Ukrainian","Uruguayan","Uzbek","Vatican citizen","Venezuelan","Vietnamese","Vincentian","Wallisian","Welsh","Yemeni","Zambian","Zimbabwean"]

//MARK: - Network Contanst

//BaseURL
//let networking = Networking(baseURL: "http://www.atocash.ml/")

//Network API EndPoints
let LOGINAPI = "api/account/login"
let FORRGETPASSWORD = "api/Account/ForgotPassword"
let RESETPASSWORD = "api/Account/ResetPassword"
let REGISTER = "api/Account/Register"

//APPROVAL GROUP
let APPROVAL_DROPDOWN = "api/ApprovalGroups/ApprovalGroupsForDropdown"
let GET_APPROVALGROUP = "api/ApprovalGroups/GetApprovalGroups"
let APPROVELGROUP_ID = "api/ApprovalGroups/GetApprovalGroup"
let POST_APPROVALGROUP = "api/ApprovalGroups/PostApprovalGroup"
let PUT_APPROVALGROUP = "api/ApprovalGroups/PutApprovalGroup"
let DELETE_APPROVALGROUP = "api/ApprovalGroups/DeleteApprovalGroup"

//APPROVAL LEVEL
let APPROVAL_LEVEL = "api/ApprovalLevels"

//APPROVAL ROLE MAPS
let APPROVAL_ROLE_MAP = "api/ApprovalRoleMaps"

//APPROVAL STATUS_TYPE
let APPROVAL_STATUS_TYPE = "api/ApprovalStatusTypes"

//CLAIM_STATUS_TRACKER
let GetClaimApprovalStatusTrackers = "api/ClaimApprovalStatusTrackers/GetClaimApprovalStatusTrackers"
let PUTClaimApprovalStatusTrackers = "api/ClaimApprovalStatusTrackers/PutClaimApprovalStatusTracker"
let POSTClaimApprovalStatusTrackers = "api/ClaimApprovalStatusTrackers/PostClaimApprovalStatusTracker"
let DELETEClaimApprovalStatusTrackers = "api/ClaimApprovalStatusTrackers/DeleteClaimApprovalStatusTracker"
let GetApprovalpending = "api/ClaimApprovalStatusTrackers/ApprovalsPendingForApprover"
let GetClaimApprovalStatusCounting = "api/ClaimApprovalStatusTrackers/CountOfApprovalsPendingForApprover"
let GetApprovalFlowForRequest = "api/ClaimApprovalStatusTrackers/ApprovalFlowForRequest"


//CostCentres
let COSTCENETR_DROPDOWN = "api/CostCentres/CostCentresForDropdown"
let COSTCENTER = "api/CostCentres/GetCostCentres"
let GET_COSTCENTER = "api/CostCentres/GetCostCentre"
let PUT_COSTCENTER = "api/CostCentres/PutCostCentre"
let POST_COSTCENTER = "api/CostCentres/PostCostCentre"
let DELETE_COSTCENTER = "api/CostCentres/DeleteCostCentre"

//Departments
let DEPARTMENTS_DROPDOWN = "api/Departments/DepartmentsForDropdown"
let DEPARTMENTS = "api/Departments/GetDepartments"
let GET_DEPARTMENTS = "api/Departments/GetDepartment"
let PUT_DEPARTMENTS = "api/Departments/PutDepartment"
let POST_DEPARTEMENTS = "api/Departments/PostDepartment"
let DELETE_DEPARTMENTS = "api/Departments/DeleteDepartment"

//DisbursementsAndClaimsMasters
let DISBURSEMENTSMASTER = "api/DisbursementsAndClaimsMasters"
let POST_DISBURSEMENTSMASTER = "api/DisbursementsAndClaimsMasters"
let GET_DISBURSEMENTSMASTER = "api/DisbursementsAndClaimsMasters"

//EmpCurrentPettyCashBalances
let GET_PETTYCASHBALANCE  = "api/EmpCurrentPettyCashBalances"

//Employees
let EMPLOYEE_DROPDOWN = "api/Employees/EmployeesForDropdown"
let EMPLOYEES = "api/Employees/GetEmployees"
let GET_EMPLOYEE = "api/Employees/GetEmployee"
let PUT_EMPLOYEE = "api/Employees/PutEmployee"
let POST_EMPLOYEE = "api/Employees/PostEmployee"
let DELETE_EMPLOYEE = "api/Employees/DeleteEmployee"

//EmploymentTypes
let EMPLOYMENT_TYPES = "api/EmploymentTypes"

//ExpenseReimburseRequests
let EXPENSE_REIMBURSE_REQUEST = "api/ExpenseReimburseRequests"

//ExpenseTypes
let EXPENSE_TYPE  = "api/ExpenseTypes"

//JobRoles
let JOBROLES_DROPWDOWN = "api/JobRoles/JobRolesForDropdown"
let JOBROLES = "api/JobRoles/GetRoles"
let GET_JOBROLES = "api/JobRoles/GetRole"
let PUT_JOBROLES = "api/JobRoles/PutRole"
let POST_JOBROLES = "api/JobRoles/PostRole"
let DELETE_JOBROLES = "api/JobRoles/DeleteRole"

//PettyCashRequests
let PETTYCASHREQUEST = "api/PettyCashRequests/GetPettyCashRequests"
let GET_PETTYCASHREQUEST = "api/PettyCashRequests/GetPettyCashRequest"
let PUT_PETTYCASHREQUEST = "api/PettyCashRequests/PutPettyCashRequest"
let POST_PETTYCASHREQUEST = "api/PettyCashRequests/PostPettyCashRequest"
let DELETE_PETTYCASHREQUEST = "api/PettyCashRequests/DeletePettyCashRequest"
let GET_APPROVAL_PETTYCASHREQUEST = "api/PettyCashRequests/ApprovalsPendingRaisedByEmployee"
let GET_APPROVALCOUNT_PETTYCASHREQUEST = "api/PettyCashRequests/CountofApprovalsPendingRaisedByEmployee"
let Get_PEETYCASH_REQUEST = "api/PettyCashRequests/GetPettyCashRequestRaisedForEmployee"


//ProjectManagement
let PROJECTMANAGMENT = "api/ProjectManagement"

//Projects
let PROJECTS_DROPDOWN = "api/Projects/ProjectsForDropdown"
let PROJECTS = "api/Projects/GetProjects"
let GET_PROJECTS = "api/Projects/GetProject"
let PUT_PROJECTS = "api/Projects/PutProject"
let POST_PROJECTS = "api/Projects/PostProject"
let DELETE_PROJECTS = "api/Projects/DeleteProject"
let GET_SUBPROJECTSFROMPROJECT = "api/SubProjects/GetSubProjectsForProjects"
let GET_TASKFROMSUBPROJECTS = "api/WorkTasks/GetWorkTasksForSubProjects"

//Reports
let POST_REPORTCASH_EMPLOYEE = "api/Reports/CashReimburseReportByEmployee"
let POST_REPORTCASH_ADMIN = "api/Reports/CashReimburseReportByAdmin"
let POST_REPORTTRAVEL_EMPLOYEE = "api/Reports/TravelRequestReportByEmployee"
let POST_REPORTTRAVEL_ADMIN = "api/Reports/TravelRequestReportByAdmin"

//Requests
let REQUEST_DROPDOWN = "api/Requests/RequestTypesForDropdown"
let REQUEST = "api/Requests/GetRequestTypes"
let GET_REQUEST = "api/Requests/GetRequestType"
let PUT_REQUEST = "api/Requests/PutRequestType"
let POST_REQUEST = "api/Requests/PostRequestType"
let DELETE_REQUEST = "api/Requests/DeleteRequestType"

//SubProjects
let SUBPROJECT_DROPDOWN = "api/SubProjects/SubProjectsForDropdown"
let GET_PROJECT_DROPDOWN = "api/SubProjects/SubProjectsByProjectForDropdown"
let SUBPROJECT = "api/SubProjects/GetSubProjects"
let GET_SUBPROJECT = "api/SubProjects/GetSubProject"
let PUT_SUBPROJECT = "api/SubProjects/PutSubProject"
let POST_SUBPROJECT = "api/SubProjects/PostSubProject"
let DELETE_SUBPROJECT = "api/SubProjects/DeleteSubProject"

//TravelApprovalRequests
let TRAVELAPPROVALREQUEST = "api/TravelApprovalRequests"

//WeatherForecast
let WEATHER = "/WeatherForecast"

//WorkTasks
let WORKTASK_DROPDOWN = "api/WorkTasks/WorkTasksForDropdown"
let GET_SUBPRPOJECT_DROPDOWN = "api/WorkTasks/WorkTasksBySubProjectForDropdown"
let WORKTASKS = "api/WorkTasks/GetWorkTasks"
let GET_WORKTASK = "api/WorkTasks/GetWorkTask"
let PUT_WORKTASK = "api/WorkTasks/PutWorkTask"
let POST_WORKTASK = "api/WorkTasks/PostWorkTask"
let DELETE_WORKTASK = "api/WorkTasks/DeleteWorkTask"

//Administrative
let ADMIN_CREATEROLE = "api/Administration/CreateRole"
let ADMIN_LISTUSERS = "api/Administration/ListUsers"
let ADMIN_LISTROLES = "api/Administration/ListRoles"
let DELETE_ADMIN_ROLE = "api/Administration/DeleteRole"
let DELETE_ADMIN_USER = "api/Administration/DeleteUser"
let PUT_ADMIN_ROLE = "api/Administration/EditRole"
let PUT_ADMIN_USER = "api/Administration/EditUser"
let ADMIN_ASSIGN_POST = "api/Administration/AssignRole"

