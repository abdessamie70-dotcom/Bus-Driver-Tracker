/**
 * ============================================================
 * Bus Driver Tracker - Core Application Architecture
 * Fully Modular, Production-Ready, Bilingual (AR/EN), 
 * LocalStorage Persistence & Excel/CSV Export
 * ============================================================
 */

// --- 1. Internationalization (i18n) Dictionary ---
const I18N = {
  ar: {
    appTitle: "نظام متابعة سائقي الحافلات",
    appSubtitle: "مؤسسة سويقات أبو طالب • إدارة الرحلات اليومية والأسطول وحضور السائقين",
    navDashboard: "لوحة التحكم",
    navTrips: "سجل الرحلات اليومية",
    navReports: "التقارير الشهرية وإكسل",
    navAttendance: "حضور وأجور السائقين",
    navFleet: "السائقون والأسطول",
    
    // Quick Actions
    exportExcel: "📊 تصدير Excel",
    backupData: "💾 نسخ احتياطي",
    restoreData: "📂 استعادة",
    printReport: "🖨️ طباعة تقرير",
    logNewTrip: "➕ تسجيل رحلة جديدة",
    addNewDriver: "➕ إضافة سائق جديد",

    // Dashboard Cards
    statTotalTrips: "إجمالي الرحلات",
    statActiveDrivers: "السائقون النشطون",
    statMonthlyRevenue: "إجمالي الإيرادات",
    statFuelCosts: "تكاليف الوقود والنفقات",
    statNetBalance: "صافي الأرباح التشغيلية",

    // 50-Seater Section
    largeBusTitle: "إحصائيات حافلات النقل الكبيرة (سعة 50 راكب)",
    largeBusSubtitle: "تحليل كفاءة الإشغال ونسب الامتلاء للحافلات الكبيرة",
    stat50SeaterCount: "عدد حافلات 50 مقعد",
    stat50SeaterTrips: "رحلات حافلات 50 مقعد",
    stat50SeaterPassengers: "ركاب الحافلات الكبيرة",
    stat50SeaterOccupancy: "معدل الإشغال للحافلات الكبيرة",
    stat50SeaterEfficiency: "متوسط عدد الركاب لكل رحلة",

    // Trip Logs
    tripsTableTitle: "سجل الرحلات اليومية والعمليات",
    filterSearchPlaceholder: "بحث بالسائق، رقم الحافلة، أو الخط...",
    filterAllDrivers: "جميع السائقين",
    filterAllBuses: "جميع الحافلات",
    filter50Only: "حافلات 50 مقعد فقط",
    filterAllStatus: "جميع الحالات",
    statusCompleted: "مكتملة",
    statusInProgress: "جارية الآن",
    statusScheduled: "مجدولة",
    statusCanceled: "ملغاة",
    colDate: "التاريخ",
    colDriver: "اسم السائق",
    colBus: "رقم الحافلة",
    colRoute: "مسار الرحلة / الخط",
    colPassengers: "عدد الركاب",
    colCapacity: "الإشغال (50 مقعد)",
    colFuel: "الوقود (دج)",
    colRevenue: "الإيراد (دج)",
    colStatus: "الحالة",
    colActions: "إجراءات",
    noTripsFound: "لا توجد رحلات مسجلة مطابقة للبحث.",
    
    // Dynamic Trip Totals
    totalFilteredTrips: "مجموع الرحلات المعروضة:",
    totalFilteredPassengers: "إجمالي الركاب:",
    totalFilteredFuel: "إجمالي الوقود:",
    totalFilteredRevenue: "إجمالي الإيرادات:",
    averageOccupancy: "متوسط نسبة الإشغال:",

    // Monthly Reports
    reportsTitle: "التقرير المالي والتشغيلي المجمّع للسائقين",
    reportsSubtitle: "جدول شامل بنمط Excel لحساب إنتاجية كل سائق وحصيلة الشهر",
    selectMonthYear: "الشهر والسنة:",
    exportReportBtn: "تنزيل كشف الشهر كملف Excel (CSV)",
    colDriverName: "اسم السائق",
    colBusAssigned: "الحافلة المسندة",
    colWorkDays: "أيام العمل",
    colTripsCount: "عدد الرحلات",
    colTotalPassengers: "إجمالي الركاب",
    colTotalFuel: "مصاريف الوقود",
    colDriverWage: "أجور السائق",
    colGrossRevenue: "الإيراد الإجمالي",
    colNetProfit: "الصافي للمؤسسة",
    tableFleetTotal: "المجموع الكلي للأسطول",

    // Attendance
    attendanceTitle: "جدول حضور السائقين والمستحقات",
    selectDriver: "السائق المحدد:",
    quickFill: "⚡ ملء تلقائي",
    resetMonth: "🔄 تفريغ الشهر",
    statusWork: "عمل (حاضر)",
    statusRest: "راحة أسبوعية",
    statusAbsence: "غياب",
    statusLeave: "إجازة مرضية",
    daysCount: "أيام العمل:",
    restCount: "أيام الراحة:",
    absentCount: "أيام الغياب:",
    overtimeHours: "ساعات إضافية:",
    netWages: "صافي أجر السائق:",

    // Modals
    modalNewTripTitle: "تسجيل رحلة جديدة",
    modalEditTripTitle: "تعديل بيانات الرحلة",
    modalDriverTitle: "إدارة بيانات السائق",
    fieldDriver: "السائق:",
    fieldBusNumber: "رقم الحافلة:",
    fieldBusType: "نوع الحافلة والسعة:",
    fieldDate: "تاريخ الرحلة:",
    fieldRoute: "المسار / الخط:",
    fieldPassengers: "عدد الركاب المسجلين:",
    fieldFuel: "تكلفة الوقود / المصاريف (دج):",
    fieldRevenue: "المداخيل / التذاكر (دج):",
    fieldStatus: "حالة الرحلة:",
    fieldNotes: "ملاحظات:",
    fieldDailyWage: "أجر اليومية الافتراضي (دج):",
    fieldOvertimeRate: "أجر الساعة الإضافية (دج):",
    fieldPhone: "رقم الهاتف:",
    btnSave: "حفظ البيانات",
    btnCancel: "إلغاء",
    btnDelete: "حذف",
    btnEdit: "تعديل",
    confirmDelete: "هل أنت متأكد من الحذف؟",
    saveSuccess: "تم حفظ البيانات بنجاح!",
    deleteSuccess: "تم الحذف بنجاح."
  },
  en: {
    appTitle: "Bus Driver & Fleet Tracker",
    appSubtitle: "Daily Trip Logging, 50-Seater Large Bus Analytics, Attendance & Monthly Excel Reports",
    navDashboard: "Dashboard",
    navTrips: "Daily Trip Logs",
    navReports: "Monthly Reports & Excel",
    navAttendance: "Attendance & Wages",
    navFleet: "Drivers & Fleet",

    // Quick Actions
    phoneConnect: "📱 Open on Phone",
    exportExcel: "📊 Export Excel",
    backupData: "💾 Backup Data",
    restoreData: "📂 Restore",
    printReport: "🖨️ Print Report",
    logNewTrip: "➕ Log New Trip",
    addNewDriver: "➕ Add Driver",

    // Dashboard Cards
    statTotalTrips: "Total Trips",
    statActiveDrivers: "Active Drivers",
    statMonthlyRevenue: "Total Revenue",
    statFuelCosts: "Fuel & Expenses",
    statNetBalance: "Net Operating Balance",

    // 50-Seater Section
    largeBusTitle: "50-Seater Large Buses Analytics",
    largeBusSubtitle: "Capacity utilization, passenger load, and operational efficiency for 50-seater fleet",
    stat50SeaterCount: "50-Seater Bus Count",
    stat50SeaterTrips: "50-Seater Trips",
    stat50SeaterPassengers: "Passengers Transported",
    stat50SeaterOccupancy: "Capacity Utilization Rate",
    stat50SeaterEfficiency: "Avg Passengers / Trip",

    // Trip Logs
    tripsTableTitle: "Daily Trip Records & Operations",
    filterSearchPlaceholder: "Search by driver, bus, or route...",
    filterAllDrivers: "All Drivers",
    filterAllBuses: "All Buses",
    filter50Only: "50-Seaters Only",
    filterAllStatus: "All Statuses",
    statusCompleted: "Completed",
    statusInProgress: "In Progress",
    statusScheduled: "Scheduled",
    statusCanceled: "Canceled",
    colDate: "Date",
    colDriver: "Driver Name",
    colBus: "Bus Number",
    colRoute: "Trip Route",
    colPassengers: "Passengers",
    colCapacity: "Load (50 Seats)",
    colFuel: "Fuel (DZD)",
    colRevenue: "Revenue (DZD)",
    colStatus: "Status",
    colActions: "Actions",
    noTripsFound: "No matching trip records found.",

    // Dynamic Trip Totals
    totalFilteredTrips: "Total Trips Shown:",
    totalFilteredPassengers: "Total Passengers:",
    totalFilteredFuel: "Total Fuel Cost:",
    totalFilteredRevenue: "Total Revenue:",
    averageOccupancy: "Average Occupancy:",

    // Monthly Reports
    reportsTitle: "Monthly Aggregated Performance & Payroll Report",
    reportsSubtitle: "Excel-style financial and operational metrics summary per driver",
    selectMonthYear: "Month & Year:",
    exportReportBtn: "Download Excel Summary (CSV)",
    colDriverName: "Driver Name",
    colBusAssigned: "Assigned Bus",
    colWorkDays: "Work Days",
    colTripsCount: "Trips Count",
    colTotalPassengers: "Total Passengers",
    colTotalFuel: "Fuel Expenses",
    colDriverWage: "Driver Wages",
    colGrossRevenue: "Gross Revenue",
    colNetProfit: "Company Net",
    tableFleetTotal: "Fleet Grand Total",

    // Attendance
    attendanceTitle: "Driver Attendance & Payroll Settlement",
    selectDriver: "Selected Driver:",
    quickFill: "⚡ Auto Fill",
    resetMonth: "🔄 Clear Month",
    statusWork: "Present (Work)",
    statusRest: "Weekly Rest",
    statusAbsence: "Absent",
    statusLeave: "Leave / Sick",
    daysCount: "Work Days:",
    restCount: "Rest Days:",
    absentCount: "Absent Days:",
    overtimeHours: "Overtime Hours:",
    netWages: "Net Driver Wage:",

    // Modals
    modalNewTripTitle: "Log New Bus Trip",
    modalEditTripTitle: "Edit Trip Record",
    modalDriverTitle: "Driver & Bus Details",
    fieldDriver: "Driver:",
    fieldBusNumber: "Bus Number:",
    fieldBusType: "Bus Type & Capacity:",
    fieldDate: "Trip Date:",
    fieldRoute: "Route / Line:",
    fieldPassengers: "Passenger Count:",
    fieldFuel: "Fuel / Operating Expenses (DZD):",
    fieldRevenue: "Ticket Revenue (DZD):",
    fieldStatus: "Trip Status:",
    fieldNotes: "Notes:",
    fieldDailyWage: "Daily Wage Rate (DZD):",
    fieldOvertimeRate: "Overtime Rate (DZD):",
    fieldPhone: "Phone Number:",
    btnSave: "Save Record",
    btnCancel: "Cancel",
    btnDelete: "Delete",
    btnEdit: "Edit",
    confirmDelete: "Are you sure you want to delete this record?",
    saveSuccess: "Record saved successfully!",
    deleteSuccess: "Record deleted successfully."
  }
};

const ARABIC_MONTHS = [
  "يناير (جانفي)", "فبراير (فيفري)", "مارس", "أبريل (أفريل)", "مايو (ماي)", "يونيو (جوان)",
  "يوليو (جويلية)", "أغسطس (أوت)", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
];

const ENGLISH_MONTHS = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

const ARABIC_DAYS = ["الأحد", "الإثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة", "السبت"];
const ENGLISH_DAYS = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

// --- 2. Application State ---
let state = {
  lang: "ar", // 'ar' | 'en'
  activeTab: "dashboard", // 'dashboard' | 'trips' | 'reports' | 'attendance' | 'fleet'
  currentYear: 2026,
  currentMonth: 8, // September (0-indexed)
  currentDriverId: null,
  selectedDayNumber: null,
  
  // Fleet / Drivers
  drivers: [],
  
  // Daily Trips
  trips: [],
  
  // Attendance: key = `${driverId}_${year}_${month}`
  attendanceData: {},

  // Filters for Trips Tab
  tripFilters: {
    search: "",
    driverId: "",
    busType: "all", // 'all' | '50_only'
    status: "all"
  }
};

// --- 3. Initial Demo Seed Data ---
function getInitialSeedData() {
  const drivers = [
    {
      id: "drv_1",
      name: "أحمد بن علي / Ahmed Benali",
      busNumber: "12 (01452-116-16)",
      busType: "50_seater",
      capacity: 50,
      phone: "0550123456",
      dailyWage: 2800,
      overtimeRate: 450,
      active: true
    },
    {
      id: "drv_2",
      name: "مراد قدور / Mourad Kaddour",
      busNumber: "08 (02891-118-16)",
      busType: "50_seater",
      capacity: 50,
      phone: "0661234567",
      dailyWage: 2800,
      overtimeRate: 450,
      active: true
    },
    {
      id: "drv_3",
      name: "سفيان بلقاسم / Sofiane Belkacem",
      busNumber: "19 (03412-119-16)",
      busType: "50_seater",
      capacity: 50,
      phone: "0770345678",
      dailyWage: 3000,
      overtimeRate: 500,
      active: true
    },
    {
      id: "drv_4",
      name: "كمال شريف / Kamel Cherif",
      busNumber: "04 (00921-115-16)",
      busType: "minibus",
      capacity: 30,
      phone: "0559876543",
      dailyWage: 2400,
      overtimeRate: 400,
      active: true
    }
  ];

  // Seed trips for current month
  const trips = [
    {
      id: "trip_101",
      date: "2026-09-24",
      driverId: "drv_1",
      busNumber: "12",
      busCapacity: 50,
      is50Seater: true,
      route: "المحطة المركزية ➔ الجامعة المركزية (Line A)",
      passengerCount: 48,
      fuelExpense: 2200,
      revenue: 4800,
      status: "completed",
      notes: "رحلة صباحية عالية الإشغال"
    },
    {
      id: "trip_102",
      date: "2026-09-24",
      driverId: "drv_2",
      busNumber: "08",
      busCapacity: 50,
      is50Seater: true,
      route: "حي النور ➔ وسط المدينة (Line B)",
      passengerCount: 45,
      fuelExpense: 2100,
      revenue: 4500,
      status: "completed",
      notes: "انتظام تام في المواعيد"
    },
    {
      id: "trip_103",
      date: "2026-09-24",
      driverId: "drv_3",
      busNumber: "19",
      busCapacity: 50,
      is50Seater: true,
      route: "المطار الدولي ➔ محطة الحافلات الكبرى",
      passengerCount: 50,
      fuelExpense: 2600,
      revenue: 6000,
      status: "completed",
      notes: "حافلة كبيرة كاملة المقاعد 100%"
    },
    {
      id: "trip_104",
      date: "2026-09-23",
      driverId: "drv_1",
      busNumber: "12",
      busCapacity: 50,
      is50Seater: true,
      route: "الجامعة المركزية ➔ المحطة المركزية",
      passengerCount: 42,
      fuelExpense: 2200,
      revenue: 4200,
      status: "completed",
      notes: "رحلة المساء"
    },
    {
      id: "trip_105",
      date: "2026-09-23",
      driverId: "drv_2",
      busNumber: "08",
      busCapacity: 50,
      is50Seater: true,
      route: "وسط المدينة ➔ حي النور",
      passengerCount: 39,
      fuelExpense: 2100,
      revenue: 3900,
      status: "completed",
      notes: "حركة مرور معتدلة"
    },
    {
      id: "trip_106",
      date: "2026-09-22",
      driverId: "drv_4",
      busNumber: "04",
      busCapacity: 30,
      is50Seater: false,
      route: "خط النقل التكميلي - الضواحي",
      passengerCount: 28,
      fuelExpense: 1400,
      revenue: 2800,
      status: "completed",
      notes: "حافلة صغيرة"
    }
  ];

  return { drivers, trips };
}

// --- 4. Storage & Persistence Management ---
function loadFromLocalStorage() {
  try {
    const savedLang = localStorage.getItem("bus_tracker_lang");
    if (savedLang === "ar" || savedLang === "en") {
      state.lang = savedLang;
    }

    const savedDrivers = localStorage.getItem("bus_tracker_drivers");
    const savedTrips = localStorage.getItem("bus_tracker_trips");
    const savedAttendance = localStorage.getItem("bus_tracker_attendance");

    if (savedDrivers && savedTrips) {
      state.drivers = JSON.parse(savedDrivers);
      state.trips = JSON.parse(savedTrips);
    } else {
      const initial = getInitialSeedData();
      state.drivers = initial.drivers;
      state.trips = initial.trips;
      saveDriversToLocalStorage();
      saveTripsToLocalStorage();
    }

    if (savedAttendance) {
      state.attendanceData = JSON.parse(savedAttendance);
    }

    // Active Driver
    const lastActiveDriver = localStorage.getItem("bus_tracker_active_driver");
    if (lastActiveDriver && state.drivers.some(d => d.id === lastActiveDriver)) {
      state.currentDriverId = lastActiveDriver;
    } else {
      state.currentDriverId = state.drivers[0]?.id || null;
    }

    // Current Date
    const today = new Date();
    state.currentYear = today.getFullYear();
    state.currentMonth = today.getMonth();

  } catch (err) {
    console.error("Storage loading error:", err);
  }
}

function saveDriversToLocalStorage() {
  localStorage.setItem("bus_tracker_drivers", JSON.stringify(state.drivers));
}

function saveTripsToLocalStorage() {
  localStorage.setItem("bus_tracker_trips", JSON.stringify(state.trips));
}

function saveAttendanceToLocalStorage() {
  localStorage.setItem("bus_tracker_attendance", JSON.stringify(state.attendanceData));
}

function saveActiveDriverToLocalStorage() {
  if (state.currentDriverId) {
    localStorage.setItem("bus_tracker_active_driver", state.currentDriverId);
  }
}

// --- 5. Internationalization & UI Translation ---
function t(key) {
  const dict = I18N[state.lang] || I18N.ar;
  return dict[key] !== undefined ? dict[key] : (I18N.ar[key] || key);
}

function setLanguage() {
  state.lang = "ar";
  document.documentElement.lang = "ar";
  document.documentElement.dir = "rtl";

  renderDriverSelect();
  renderTripsFilterOptions();
  renderActiveTab();
}

function translateStaticElements() {
  document.querySelectorAll("[data-i18n]").forEach(elem => {
    const key = elem.getAttribute("data-i18n");
    if (key) elem.textContent = t(key);
  });

  document.querySelectorAll("[data-i18n-placeholder]").forEach(elem => {
    const key = elem.getAttribute("data-i18n-placeholder");
    if (key) elem.placeholder = t(key);
  });
}

// --- 6. Helper Utilities ---
function formatCurrency(val) {
  const num = Number(val) || 0;
  return num.toLocaleString() + " " + (state.lang === "ar" ? "دج" : "DZD");
}

function showToast(message, type = "success") {
  const container = document.getElementById("toastContainer");
  if (!container) return;

  const toast = document.createElement("div");
  toast.className = `toast toast-${type}`;
  toast.innerHTML = `<span>${type === 'success' ? '✅' : type === 'error' ? '❌' : 'ℹ️'}</span> <span>${message}</span>`;
  container.appendChild(toast);

  setTimeout(() => {
    toast.style.opacity = "0";
    toast.style.transform = "translateY(10px)";
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

function getMonthName(monthIndex) {
  return state.lang === "ar" ? ARABIC_MONTHS[monthIndex] : ENGLISH_MONTHS[monthIndex];
}

function getDayName(dayIndex) {
  return state.lang === "ar" ? ARABIC_DAYS[dayIndex] : ENGLISH_DAYS[dayIndex];
}

function getMonthKey(driverId = state.currentDriverId, year = state.currentYear, month = state.currentMonth) {
  return `${driverId}_${year}_${month}`;
}

function getCurrentMonthAttendance() {
  const key = getMonthKey();
  if (!state.attendanceData[key]) {
    state.attendanceData[key] = {
      days: {},
      bonus: 0,
      deduction: 0
    };
  }
  return state.attendanceData[key];
}

function getCurrentDriver() {
  return state.drivers.find(d => d.id === state.currentDriverId) || state.drivers[0] || null;
}

// --- 7. Tab Navigation ---
function switchTab(tabId) {
  state.activeTab = tabId;

  document.querySelectorAll(".nav-tab-btn, .android-bottom-nav-btn").forEach(btn => {
    if (btn.dataset.tab === tabId) {
      btn.classList.add("active");
    } else {
      btn.classList.remove("active");
    }
  });

  document.querySelectorAll(".tab-content").forEach(content => {
    if (content.id === `tab-${tabId}`) {
      content.classList.remove("hidden");
    } else {
      content.classList.add("hidden");
    }
  });

  // Scroll smoothly to top on mobile tab switch
  window.scrollTo({ top: 0, behavior: "smooth" });

  renderActiveTab();
}

function renderActiveTab() {
  switch (state.activeTab) {
    case "dashboard":
      renderDashboard();
      break;
    case "trips":
      renderTripsTable();
      break;
    case "reports":
      renderMonthlyReports();
      break;
    case "attendance":
      renderAttendanceView();
      break;
    case "fleet":
      renderFleetView();
      break;
    case "bookings":
      renderBookingsView();
      break;
  }
}

// --- 8. Tab 1: Dashboard & 50-Seater Large Buses Analytics ---
function renderDashboard() {
  const currentMonthTrips = state.trips.filter(trip => {
    if (!trip.date) return false;
    const d = new Date(trip.date);
    return d.getFullYear() === state.currentYear && d.getMonth() === state.currentMonth;
  });

  // Basic Metrics
  const totalTrips = currentMonthTrips.length;
  const activeDriversCount = state.drivers.length;
  const totalRevenue = currentMonthTrips.reduce((sum, t) => sum + (Number(t.revenue) || 0), 0);
  const totalFuel = currentMonthTrips.reduce((sum, t) => sum + (Number(t.fuelExpense) || 0), 0);
  const netBalance = totalRevenue - totalFuel;

  // 50-Seater Large Bus Dedicated Metrics
  const large50Buses = state.drivers.filter(d => d.busType === "50_seater" || Number(d.capacity) === 50);
  const large50Trips = currentMonthTrips.filter(t => t.is50Seater || Number(t.busCapacity) === 50);
  const large50Passengers = large50Trips.reduce((sum, t) => sum + (Number(t.passengerCount) || 0), 0);
  
  // Total potential seating capacity = trips * 50
  const totalPotentialCapacity = large50Trips.length * 50;
  const occupancyRate = totalPotentialCapacity > 0 
    ? Math.round((large50Passengers / totalPotentialCapacity) * 100) 
    : 0;
  
  const avgLoadPerTrip = large50Trips.length > 0 
    ? (large50Passengers / large50Trips.length).toFixed(1) 
    : 0;

  // Update DOM elements
  document.getElementById("dashTotalTrips").textContent = totalTrips;
  document.getElementById("dashActiveDrivers").textContent = activeDriversCount;
  document.getElementById("dashRevenue").textContent = formatCurrency(totalRevenue);
  document.getElementById("dashFuel").textContent = formatCurrency(totalFuel);
  document.getElementById("dashNet").textContent = formatCurrency(netBalance);

  document.getElementById("dash50Count").textContent = large50Buses.length;
  document.getElementById("dash50Trips").textContent = large50Trips.length;
  document.getElementById("dash50Passengers").textContent = large50Passengers.toLocaleString();
  document.getElementById("dash50Occupancy").textContent = occupancyRate + "%";
  document.getElementById("dash50Efficiency").textContent = avgLoadPerTrip + (state.lang === "ar" ? " راكب/رحلة" : " pass/trip");

  // Visual occupancy bar
  const meter = document.getElementById("dash50MeterFill");
  if (meter) {
    meter.style.width = `${Math.min(occupancyRate, 100)}%`;
    meter.className = `occupancy-meter-fill ${occupancyRate >= 80 ? 'bg-emerald-500' : occupancyRate >= 50 ? 'bg-amber-500' : 'bg-rose-500'}`;
  }

  // Recent Trips Preview
  const recentTable = document.getElementById("dashRecentTripsTableBody");
  if (recentTable) {
    recentTable.innerHTML = "";
    const recent = [...state.trips].sort((a, b) => new Date(b.date) - new Date(a.date)).slice(0, 5);
    
    if (recent.length === 0) {
      recentTable.innerHTML = `<tr><td colspan="6" class="text-center py-4 text-slate-400">${t("noTripsFound")}</td></tr>`;
    } else {
      recent.forEach(trip => {
        const driver = state.drivers.find(d => d.id === trip.driverId);
        const tr = document.createElement("tr");
        tr.className = "border-b border-slate-100 hover:bg-slate-50 transition-colors";
        tr.innerHTML = `
          <td class="py-2.5 px-3 text-slate-600">${trip.date}</td>
          <td class="py-2.5 px-3 font-semibold text-slate-800">${driver?.name || "-"}</td>
          <td class="py-2.5 px-3">
            <span class="inline-flex items-center gap-1 font-mono text-xs px-2 py-0.5 rounded bg-slate-100 text-slate-700">
              🚌 ${trip.busNumber || "-"}
              ${trip.is50Seater ? '<span class="text-blue-600 font-bold">(50)</span>' : ''}
            </span>
          </td>
          <td class="py-2.5 px-3 text-slate-700">${trip.route || "-"}</td>
          <td class="py-2.5 px-3 font-semibold text-center text-slate-800">
            ${trip.passengerCount} / ${trip.busCapacity || 50}
          </td>
          <td class="py-2.5 px-3 font-mono font-bold text-emerald-600">${formatCurrency(trip.revenue || 0)}</td>
        `;
        recentTable.appendChild(tr);
      });
    }
  }

  // Top Drivers Leaderboard
  renderTopDriversLeaderboard(currentMonthTrips);
}

function renderTopDriversLeaderboard(currentMonthTrips) {
  const container = document.getElementById("dashTopDriversList");
  if (!container) return;
  container.innerHTML = "";

  const driverStats = state.drivers.map(driver => {
    const driverTrips = currentMonthTrips.filter(t => t.driverId === driver.id);
    const tripsCount = driverTrips.length;
    const totalPax = driverTrips.reduce((acc, t) => acc + (Number(t.passengerCount) || 0), 0);
    const totalRev = driverTrips.reduce((acc, t) => acc + (Number(t.revenue) || 0), 0);
    return { driver, tripsCount, totalPax, totalRev };
  }).sort((a, b) => b.tripsCount - a.tripsCount);

  driverStats.forEach((item, idx) => {
    const div = document.createElement("div");
    div.className = "flex items-center justify-between p-3 rounded-lg border border-slate-100 bg-white hover:border-blue-200 transition-colors";
    div.innerHTML = `
      <div class="flex items-center gap-3">
        <span class="w-7 h-7 rounded-full flex items-center justify-center font-bold text-xs ${idx === 0 ? 'bg-amber-100 text-amber-700' : 'bg-slate-100 text-slate-600'}">
          ${idx + 1}
        </span>
        <div>
          <p class="font-bold text-slate-800 text-sm">${item.driver.name}</p>
          <span class="text-xs text-slate-500 font-mono">🚌 ${item.driver.busNumber || '-'}</span>
        </div>
      </div>
      <div class="text-end">
        <span class="inline-block text-xs font-bold text-blue-700 bg-blue-50 px-2 py-0.5 rounded">
          ${item.tripsCount} ${state.lang === 'ar' ? 'رحلة' : 'trips'}
        </span>
        <p class="text-xs text-slate-500 mt-0.5">${item.totalPax.toLocaleString()} ${state.lang === 'ar' ? 'راكب' : 'pax'}</p>
      </div>
    `;
    container.appendChild(div);
  });
}

// --- 9. Tab 2: Daily Trip Logs & Management ---
function renderTripsFilterOptions() {
  const driverFilter = document.getElementById("filterTripDriver");
  if (driverFilter) {
    driverFilter.innerHTML = `<option value="">${t("filterAllDrivers")}</option>`;
    state.drivers.forEach(d => {
      const opt = document.createElement("option");
      opt.value = d.id;
      opt.textContent = `${d.name} (${d.busNumber || '-'})`;
      driverFilter.appendChild(opt);
    });
  }
}

function renderTripsTable() {
  const tbody = document.getElementById("tripsTableBody");
  if (!tbody) return;
  tbody.innerHTML = "";

  const { search, driverId, busType, status } = state.tripFilters;

  // Filter trips
  const filtered = state.trips.filter(trip => {
    const matchesSearch = !search || 
      (trip.route && trip.route.toLowerCase().includes(search.toLowerCase())) ||
      (trip.busNumber && trip.busNumber.toLowerCase().includes(search.toLowerCase())) ||
      (trip.notes && trip.notes.toLowerCase().includes(search.toLowerCase()));

    const matchesDriver = !driverId || trip.driverId === driverId;
    const matchesBus = busType === "all" || (busType === "50_only" && (trip.is50Seater || Number(trip.busCapacity) === 50));
    const matchesStatus = status === "all" || trip.status === status;

    return matchesSearch && matchesDriver && matchesBus && matchesStatus;
  }).sort((a, b) => new Date(b.date) - new Date(a.date));

  // Dynamic calculations for filtered trips
  let sumPassengers = 0;
  let sumFuel = 0;
  let sumRevenue = 0;
  let sumPotentialCapacity = 0;

  if (filtered.length === 0) {
    tbody.innerHTML = `<tr><td colspan="10" class="text-center py-8 text-slate-400 font-medium">${t("noTripsFound")}</td></tr>`;
  } else {
    filtered.forEach(trip => {
      const driver = state.drivers.find(d => d.id === trip.driverId);
      const capacity = Number(trip.busCapacity) || 50;
      const passengers = Number(trip.passengerCount) || 0;
      const occupancyPct = Math.round((passengers / capacity) * 100);

      sumPassengers += passengers;
      sumFuel += Number(trip.fuelExpense) || 0;
      sumRevenue += Number(trip.revenue) || 0;
      sumPotentialCapacity += capacity;

      const tr = document.createElement("tr");
      tr.className = "border-b border-slate-200 hover:bg-slate-50 transition-colors text-sm";
      tr.innerHTML = `
        <td class="py-3 px-3 font-mono text-slate-600 whitespace-nowrap">${trip.date}</td>
        <td class="py-3 px-3 font-semibold text-slate-800">${driver?.name || "-"}</td>
        <td class="py-3 px-3 whitespace-nowrap">
          <span class="inline-flex items-center gap-1 font-mono text-xs px-2 py-0.5 rounded ${trip.is50Seater ? 'bg-blue-100 text-blue-800 border border-blue-200 font-bold' : 'bg-slate-100 text-slate-700'}">
            🚌 ${trip.busNumber || "-"}
            ${trip.is50Seater ? '<span class="text-[10px] bg-blue-600 text-white rounded px-1">50</span>' : ''}
          </span>
        </td>
        <td class="py-3 px-3 text-slate-700">${trip.route || "-"}</td>
        <td class="py-3 px-3 font-bold text-center text-slate-900">${passengers}</td>
        <td class="py-3 px-3 text-center">
          <div class="flex items-center justify-center gap-1.5">
            <div class="w-16 h-2 bg-slate-200 rounded-full overflow-hidden">
              <div class="h-full ${occupancyPct >= 80 ? 'bg-emerald-500' : occupancyPct >= 50 ? 'bg-amber-500' : 'bg-rose-500'}" style="width: ${Math.min(occupancyPct, 100)}%"></div>
            </div>
            <span class="text-xs font-mono font-bold ${occupancyPct >= 80 ? 'text-emerald-700' : occupancyPct >= 50 ? 'text-amber-700' : 'text-rose-700'}">${occupancyPct}%</span>
          </div>
        </td>
        <td class="py-3 px-3 font-mono text-slate-700 whitespace-nowrap">${formatCurrency(trip.fuelExpense || 0)}</td>
        <td class="py-3 px-3 font-mono font-bold text-emerald-600 whitespace-nowrap">${formatCurrency(trip.revenue || 0)}</td>
        <td class="py-3 px-3 text-center whitespace-nowrap">
          ${getStatusBadgeHTML(trip.status)}
        </td>
        <td class="py-3 px-3 text-center whitespace-nowrap">
          <div class="flex items-center justify-center gap-1">
            <button class="btn-edit-trip p-1.5 hover:bg-slate-200 rounded text-slate-600 hover:text-blue-600" data-id="${trip.id}" title="${t('btnEdit')}">✏️</button>
            <button class="btn-delete-trip p-1.5 hover:bg-rose-100 rounded text-slate-600 hover:text-rose-600" data-id="${trip.id}" title="${t('btnDelete')}">🗑️</button>
          </div>
        </td>
      `;
      tbody.appendChild(tr);
    });
  }

  // Update dynamic calculations summary bar
  document.getElementById("summaryFilterTripsCount").textContent = filtered.length;
  document.getElementById("summaryFilterPassengers").textContent = sumPassengers.toLocaleString();
  document.getElementById("summaryFilterFuel").textContent = formatCurrency(sumFuel);
  document.getElementById("summaryFilterRevenue").textContent = formatCurrency(sumRevenue);

  const avgOcc = sumPotentialCapacity > 0 ? Math.round((sumPassengers / sumPotentialCapacity) * 100) : 0;
  document.getElementById("summaryFilterOccupancy").textContent = avgOcc + "%";

  // Attach Edit and Delete listeners
  tbody.querySelectorAll(".btn-edit-trip").forEach(btn => {
    btn.addEventListener("click", () => {
      const tripId = btn.dataset.id;
      const trip = state.trips.find(t => t.id === tripId);
      if (trip) openTripModal(trip);
    });
  });

  tbody.querySelectorAll(".btn-delete-trip").forEach(btn => {
    btn.addEventListener("click", () => {
      const tripId = btn.dataset.id;
      if (confirm(t("confirmDelete"))) {
        state.trips = state.trips.filter(t => t.id !== tripId);
        saveTripsToLocalStorage();
        renderTripsTable();
        showToast(t("deleteSuccess"), "success");
      }
    });
  });
}

function getStatusBadgeHTML(status) {
  switch (status) {
    case "completed":
      return `<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-800">${t("statusCompleted")}</span>`;
    case "in_progress":
      return `<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">${t("statusInProgress")}</span>`;
    case "scheduled":
      return `<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-800">${t("statusScheduled")}</span>`;
    case "canceled":
      return `<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-rose-100 text-rose-800">${t("statusCanceled")}</span>`;
    default:
      return `<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-slate-100 text-slate-800">${status || "-"}</span>`;
  }
}

// --- 10. Trip Modal (Add & Edit) ---
function openTripModal(tripToEdit = null) {
  const modal = document.getElementById("tripModal");
  const modalTitle = document.getElementById("tripModalTitle");
  const form = document.getElementById("tripForm");
  
  // Populate Driver Select in Modal
  const driverSelect = document.getElementById("tripDriverSelect");
  driverSelect.innerHTML = "";
  state.drivers.forEach(d => {
    const opt = document.createElement("option");
    opt.value = d.id;
    opt.textContent = `${d.name} (${d.busNumber || '-'})`;
    driverSelect.appendChild(opt);
  });

  // When driver changes, auto-fill bus number and capacity
  driverSelect.onchange = () => {
    const selected = state.drivers.find(d => d.id === driverSelect.value);
    if (selected) {
      document.getElementById("tripBusNumber").value = selected.busNumber || "";
      const is50 = selected.busType === "50_seater" || Number(selected.capacity) === 50;
      document.getElementById("tripIs50Seater").checked = is50;
      document.getElementById("tripBusCapacity").value = selected.capacity || (is50 ? 50 : 30);
    }
  };

  if (tripToEdit) {
    modalTitle.textContent = t("modalEditTripTitle");
    document.getElementById("tripIdInput").value = tripToEdit.id;
    driverSelect.value = tripToEdit.driverId;
    document.getElementById("tripBusNumber").value = tripToEdit.busNumber || "";
    document.getElementById("tripIs50Seater").checked = !!tripToEdit.is50Seater;
    document.getElementById("tripBusCapacity").value = tripToEdit.busCapacity || 50;
    document.getElementById("tripDate").value = tripToEdit.date || new Date().toISOString().slice(0, 10);
    document.getElementById("tripRoute").value = tripToEdit.route || "";
    document.getElementById("tripPassengers").value = tripToEdit.passengerCount || 0;
    document.getElementById("tripFuel").value = tripToEdit.fuelExpense || 0;
    document.getElementById("tripRevenue").value = tripToEdit.revenue || 0;
    document.getElementById("tripStatus").value = tripToEdit.status || "completed";
    document.getElementById("tripNotes").value = tripToEdit.notes || "";
  } else {
    modalTitle.textContent = t("modalNewTripTitle");
    form.reset();
    document.getElementById("tripIdInput").value = "";
    document.getElementById("tripDate").value = new Date().toISOString().slice(0, 10);
    if (state.drivers.length > 0) {
      driverSelect.value = state.currentDriverId || state.drivers[0].id;
      driverSelect.onchange();
    }
  }

  modal.classList.add("active");
}

function closeTripModal() {
  document.getElementById("tripModal").classList.remove("active");
}

function handleSaveTrip(e) {
  e.preventDefault();

  const id = document.getElementById("tripIdInput").value;
  const driverId = document.getElementById("tripDriverSelect").value;
  const busNumber = document.getElementById("tripBusNumber").value.trim();
  const is50Seater = document.getElementById("tripIs50Seater").checked;
  const busCapacity = Number(document.getElementById("tripBusCapacity").value) || 50;
  const date = document.getElementById("tripDate").value;
  const route = document.getElementById("tripRoute").value.trim();
  const passengerCount = Number(document.getElementById("tripPassengers").value) || 0;
  const fuelExpense = Number(document.getElementById("tripFuel").value) || 0;
  const revenue = Number(document.getElementById("tripRevenue").value) || 0;
  const status = document.getElementById("tripStatus").value;
  const notes = document.getElementById("tripNotes").value.trim();

  if (!driverId || !date || !route) {
    alert(state.lang === "ar" ? "يرجى ملء جميع الحقول المطلوبة (السائق، التاريخ، والمسار)." : "Please fill in all required fields.");
    return;
  }

  if (id) {
    // Edit existing trip
    const index = state.trips.findIndex(t => t.id === id);
    if (index !== -1) {
      state.trips[index] = {
        ...state.trips[index],
        driverId,
        busNumber,
        is50Seater,
        busCapacity,
        date,
        route,
        passengerCount,
        fuelExpense,
        revenue,
        status,
        notes
      };
    }
  } else {
    // Add new trip
    const newTrip = {
      id: "trip_" + Date.now(),
      driverId,
      busNumber,
      is50Seater,
      busCapacity,
      date,
      route,
      passengerCount,
      fuelExpense,
      revenue,
      status,
      notes
    };
    state.trips.unshift(newTrip);
  }

  saveTripsToLocalStorage();
  closeTripModal();
  renderTripsTable();
  if (state.activeTab === "dashboard") renderDashboard();
  showToast(t("saveSuccess"), "success");
}

// --- 11. Tab 3: Monthly Summary & Excel Reports ---
function renderMonthlyReports() {
  const monthName = getMonthName(state.currentMonth);
  document.getElementById("reportMonthYearLabel").textContent = `${monthName} ${state.currentYear}`;

  const tbody = document.getElementById("monthlyReportsTableBody");
  if (!tbody) return;
  tbody.innerHTML = "";

  // Filter trips for this month & year
  const monthTrips = state.trips.filter(t => {
    if (!t.date) return false;
    const d = new Date(t.date);
    return d.getFullYear() === state.currentYear && d.getMonth() === state.currentMonth;
  });

  let grandTrips = 0;
  let grandPassengers = 0;
  let grandFuel = 0;
  let grandWages = 0;
  let grandRevenue = 0;
  let grandNet = 0;

  state.drivers.forEach(driver => {
    const driverTrips = monthTrips.filter(t => t.driverId === driver.id);
    const tripsCount = driverTrips.length;
    const passengersCount = driverTrips.reduce((acc, t) => acc + (Number(t.passengerCount) || 0), 0);
    const fuelExpenses = driverTrips.reduce((acc, t) => acc + (Number(t.fuelExpense) || 0), 0);
    const grossRevenue = driverTrips.reduce((acc, t) => acc + (Number(t.revenue) || 0), 0);

    // Work days from attendance
    const attendanceKey = getMonthKey(driver.id, state.currentYear, state.currentMonth);
    const attRecord = state.attendanceData[attendanceKey] || { days: {}, bonus: 0, deduction: 0 };
    
    let workDaysCount = 0;
    let overtimeHours = 0;
    Object.values(attRecord.days || {}).forEach(d => {
      if (d.status === "work") workDaysCount++;
      if (d.overtime) overtimeHours += Number(d.overtime);
    });

    const driverBaseWages = workDaysCount * Number(driver.dailyWage || 0);
    const driverOvertimeWages = overtimeHours * Number(driver.overtimeRate || 0);
    const totalDriverWages = driverBaseWages + driverOvertimeWages + (Number(attRecord.bonus) || 0) - (Number(attRecord.deduction) || 0);

    // Company Net Profit = Revenue - Fuel - Driver Wages
    const companyNet = grossRevenue - fuelExpenses - totalDriverWages;

    grandTrips += tripsCount;
    grandPassengers += passengersCount;
    grandFuel += fuelExpenses;
    grandWages += totalDriverWages;
    grandRevenue += grossRevenue;
    grandNet += companyNet;

    const tr = document.createElement("tr");
    tr.className = "border-b border-slate-200 hover:bg-slate-50 transition-colors text-sm";
    tr.innerHTML = `
      <td class="py-3 px-3 font-bold text-slate-800">${driver.name}</td>
      <td class="py-3 px-3 font-mono text-slate-600">
        🚌 ${driver.busNumber || '-'}
        ${driver.busType === '50_seater' || driver.capacity === 50 ? '<span class="text-xs bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded ms-1">50 مقعد</span>' : ''}
      </td>
      <td class="py-3 px-3 text-center font-semibold text-slate-700">${workDaysCount}</td>
      <td class="py-3 px-3 text-center font-bold text-blue-700">${tripsCount}</td>
      <td class="py-3 px-3 text-center font-semibold text-slate-800">${passengersCount.toLocaleString()}</td>
      <td class="py-3 px-3 font-mono text-slate-700">${formatCurrency(fuelExpenses)}</td>
      <td class="py-3 px-3 font-mono font-semibold text-amber-700">${formatCurrency(totalDriverWages)}</td>
      <td class="py-3 px-3 font-mono font-bold text-emerald-600">${formatCurrency(grossRevenue)}</td>
      <td class="py-3 px-3 font-mono font-bold ${companyNet >= 0 ? 'text-blue-700' : 'text-rose-600'}">${formatCurrency(companyNet)}</td>
    `;
    tbody.appendChild(tr);
  });

  // Footer Totals Row
  document.getElementById("reportTotalTrips").textContent = grandTrips;
  document.getElementById("reportTotalPassengers").textContent = grandPassengers.toLocaleString();
  document.getElementById("reportTotalFuel").textContent = formatCurrency(grandFuel);
  document.getElementById("reportTotalWages").textContent = formatCurrency(grandWages);
  document.getElementById("reportTotalRevenue").textContent = formatCurrency(grandRevenue);
  document.getElementById("reportTotalNet").textContent = formatCurrency(grandNet);
}

// Export Monthly Report to Excel / CSV with UTF-8 BOM
function exportMonthlyReportToCSV() {
  const monthName = getMonthName(state.currentMonth);
  const year = state.currentYear;

  const monthTrips = state.trips.filter(t => {
    if (!t.date) return false;
    const d = new Date(t.date);
    return d.getFullYear() === year && d.getMonth() === state.currentMonth;
  });

  let csv = "\uFEFF"; // UTF-8 Byte Order Mark for Microsoft Excel
  csv += `تقرير نشاط وأداء سائقي الحافلات - شهر ${monthName} ${year}\n`;
  csv += `تاريخ التصدير:,${new Date().toLocaleDateString('ar-DZ')}\n\n`;
  csv += "اسم السائق,رقم الحافلة,نوع الحافلة,أيام العمل,عدد الرحلات,إجمالي الركاب,تكاليف الوقود (دج),أجور ومستحقات السائق (دج),الإيرادات الإجمالية (دج),صافي أرباح المؤسسة (دج)\n";

  let grandTrips = 0, grandPax = 0, grandFuel = 0, grandWages = 0, grandRev = 0, grandNet = 0;

  state.drivers.forEach(driver => {
    const driverTrips = monthTrips.filter(t => t.driverId === driver.id);
    const tripsCount = driverTrips.length;
    const passengersCount = driverTrips.reduce((acc, t) => acc + (Number(t.passengerCount) || 0), 0);
    const fuelExpenses = driverTrips.reduce((acc, t) => acc + (Number(t.fuelExpense) || 0), 0);
    const grossRevenue = driverTrips.reduce((acc, t) => acc + (Number(t.revenue) || 0), 0);

    const attendanceKey = getMonthKey(driver.id, year, state.currentMonth);
    const attRecord = state.attendanceData[attendanceKey] || { days: {}, bonus: 0, deduction: 0 };
    
    let workDaysCount = 0;
    let overtimeHours = 0;
    Object.values(attRecord.days || {}).forEach(d => {
      if (d.status === "work") workDaysCount++;
      if (d.overtime) overtimeHours += Number(d.overtime);
    });

    const totalDriverWages = (workDaysCount * Number(driver.dailyWage || 0)) +
                             (overtimeHours * Number(driver.overtimeRate || 0)) +
                             (Number(attRecord.bonus) || 0) - (Number(attRecord.deduction) || 0);

    const companyNet = grossRevenue - fuelExpenses - totalDriverWages;

    grandTrips += tripsCount;
    grandPax += passengersCount;
    grandFuel += fuelExpenses;
    grandWages += totalDriverWages;
    grandRev += grossRevenue;
    grandNet += companyNet;

    const busTypeStr = (driver.busType === "50_seater" || driver.capacity === 50) ? "حافلة كبيرة 50 مقعد" : "حافلة قياسية";
    const driverNameEsc = `"${driver.name.replace(/"/g, '""')}"`;
    const busNumEsc = `"${(driver.busNumber || '').replace(/"/g, '""')}"`;

    csv += `${driverNameEsc},${busNumEsc},${busTypeStr},${workDaysCount},${tripsCount},${passengersCount},${fuelExpenses},${totalDriverWages},${grossRevenue},${companyNet}\n`;
  });

  csv += `\nالمجموع الكلي,,,"-",${grandTrips},${grandPax},${grandFuel},${grandWages},${grandRev},${grandNet}\n`;

  const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.setAttribute("href", url);
  link.setAttribute("download", `تقرير_حافلات_${state.currentMonth + 1}_${year}.csv`);
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  showToast(state.lang === "ar" ? "تم تصدير ملف الإكسل بنجاح!" : "Excel file exported successfully!");
}

// --- 12. Tab 4: Attendance & Calendar Logic ---
function renderAttendanceView() {
  updateAttendanceHeader();
  renderCalendar();
  updateStatisticsAndFinance();
}

function updateAttendanceHeader() {
  const driver = getCurrentDriver();
  if (driver) {
    document.getElementById("dispBusNumber").textContent = driver.busNumber || "-";
    document.getElementById("dispDailyWage").textContent = Number(driver.dailyWage || 0).toLocaleString();
    document.getElementById("dispOvertimeRate").textContent = Number(driver.overtimeRate || 0).toLocaleString();
  }

  const monthName = getMonthName(state.currentMonth);
  document.getElementById("currentMonthYearLabel").textContent = `${monthName} ${state.currentYear}`;
  document.getElementById("calendarTitle").textContent = `${t("attendanceTitle")} - ${monthName} ${state.currentYear}`;
}

function renderDriverSelect() {
  const select = document.getElementById("driverSelect");
  if (!select) return;
  select.innerHTML = "";
  state.drivers.forEach(driver => {
    const opt = document.createElement("option");
    opt.value = driver.id;
    opt.textContent = `${driver.name} (${driver.busNumber || '-'})`;
    if (driver.id === state.currentDriverId) {
      opt.selected = true;
    }
    select.appendChild(opt);
  });
}

function renderCalendar() {
  const grid = document.getElementById("calendarGrid");
  if (!grid) return;
  grid.innerHTML = "";

  const monthData = getCurrentMonthAttendance();
  const year = state.currentYear;
  const month = state.currentMonth;

  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const firstDayObj = new Date(year, month, 1);
  const jsDay = firstDayObj.getDay();
  // Saturday-based index: 0 = Saturday, 1 = Sunday, etc.
  const saturdayIndex = (jsDay + 1) % 7;

  // Empty leading cells
  for (let i = 0; i < saturdayIndex; i++) {
    const emptyCell = document.createElement("div");
    emptyCell.className = "day-cell empty";
    grid.appendChild(emptyCell);
  }

  const today = new Date();
  const isCurrentRealMonth = today.getFullYear() === year && today.getMonth() === month;

  for (let day = 1; day <= daysInMonth; day++) {
    const dateObj = new Date(year, month, day);
    const dayName = getDayName(dateObj.getDay());
    const dayRecord = monthData.days[day] || { status: "work", overtime: 0, trips: "", notes: "" };

    const cell = document.createElement("div");
    cell.className = `day-cell status-${dayRecord.status || 'work'}`;
    if (isCurrentRealMonth && today.getDate() === day) {
      cell.classList.add("is-today");
    }

    const header = document.createElement("div");
    header.className = "day-header";
    header.innerHTML = `
      <span class="day-number">${day}</span>
      <span class="day-name-small">${dayName}</span>
      <button class="btn-day-edit" title="${t('btnEdit')}" data-day="${day}">✏️</button>
    `;

    const statusPill = document.createElement("div");
    statusPill.className = "day-status-pill";
    statusPill.innerHTML = getAttendanceStatusHTML(dayRecord.status);

    const extraInfo = document.createElement("div");
    extraInfo.className = "day-extra-info";
    
    if (dayRecord.overtime && Number(dayRecord.overtime) > 0) {
      const otBadge = document.createElement("span");
      otBadge.className = "badge-overtime-pill";
      otBadge.textContent = `+${dayRecord.overtime}h`;
      extraInfo.appendChild(otBadge);
    }

    if (dayRecord.trips) {
      const tripText = document.createElement("span");
      tripText.className = "day-trip-info";
      tripText.title = dayRecord.trips;
      tripText.textContent = `🚌 ${dayRecord.trips}`;
      extraInfo.appendChild(tripText);
    }

    cell.appendChild(header);
    cell.appendChild(statusPill);
    cell.appendChild(extraInfo);

    cell.addEventListener("click", (e) => {
      if (e.target.classList.contains("btn-day-edit")) {
        e.stopPropagation();
        openDayModal(day);
        return;
      }
      cycleDayStatus(day);
    });

    grid.appendChild(cell);
  }
}

function getAttendanceStatusHTML(status) {
  switch (status) {
    case "work":
      return `🟢 ${t("statusWork")}`;
    case "rest":
      return `🔵 ${t("statusRest")}`;
    case "absence":
      return `🔴 ${t("statusAbsence")}`;
    case "leave":
      return `🟠 ${t("statusLeave")}`;
    default:
      return `🟢 ${t("statusWork")}`;
  }
}

function cycleDayStatus(day) {
  const monthData = getCurrentMonthAttendance();
  const currentStatus = monthData.days[day]?.status || "work";
  const cycle = {
    work: "rest",
    rest: "absence",
    absence: "leave",
    leave: "work"
  };

  const nextStatus = cycle[currentStatus] || "work";
  if (!monthData.days[day]) {
    monthData.days[day] = { status: nextStatus, overtime: 0, trips: "", notes: "" };
  } else {
    monthData.days[day].status = nextStatus;
  }

  saveAttendanceToLocalStorage();
  renderAttendanceView();
}

function updateStatisticsAndFinance() {
  const monthData = getCurrentMonthAttendance();
  const driver = getCurrentDriver();
  const dailyWage = driver ? Number(driver.dailyWage || 0) : 0;
  const overtimeRate = driver ? Number(driver.overtimeRate || 0) : 0;

  const daysInMonth = new Date(state.currentYear, state.currentMonth + 1, 0).getDate();

  let workDays = 0, restDays = 0, absenceDays = 0, leaveDays = 0, totalOvertime = 0;

  for (let day = 1; day <= daysInMonth; day++) {
    const record = monthData.days[day] || { status: "work", overtime: 0 };
    const status = record.status || "work";

    if (status === "work") workDays++;
    else if (status === "rest") restDays++;
    else if (status === "absence") absenceDays++;
    else if (status === "leave") leaveDays++;

    if (record.overtime && Number(record.overtime) > 0) {
      totalOvertime += Number(record.overtime);
    }
  }

  document.getElementById("statWorkDays").textContent = workDays;
  document.getElementById("statRestDays").textContent = restDays;
  document.getElementById("statAbsenceDays").textContent = absenceDays;
  document.getElementById("statLeaveDays").textContent = leaveDays;
  document.getElementById("statOvertimeCount").textContent = totalOvertime;

  const baseSalary = workDays * dailyWage;
  const overtimeSalary = totalOvertime * overtimeRate;
  
  const bonusInput = document.getElementById("inputBonus");
  const deductionInput = document.getElementById("inputDeduction");

  if (bonusInput && document.activeElement !== bonusInput) {
    bonusInput.value = monthData.bonus || 0;
  }
  if (deductionInput && document.activeElement !== deductionInput) {
    deductionInput.value = monthData.deduction || 0;
  }

  const bonus = Number(monthData.bonus || 0);
  const deduction = Number(monthData.deduction || 0);
  const netTotal = Math.max(0, baseSalary + overtimeSalary + bonus - deduction);

  document.getElementById("calcWorkDaysNum").textContent = workDays;
  document.getElementById("calcDailyWageVal").textContent = dailyWage.toLocaleString();
  document.getElementById("calcBaseSalary").textContent = formatCurrency(baseSalary);

  document.getElementById("calcOvertimeNum").textContent = totalOvertime;
  document.getElementById("calcOvertimeRateVal").textContent = overtimeRate.toLocaleString();
  document.getElementById("calcOvertimeTotal").textContent = formatCurrency(overtimeSalary);

  document.getElementById("calcNetTotal").textContent = formatCurrency(netTotal);
  document.getElementById("statTotalSalary").textContent = netTotal.toLocaleString();
}

function openDayModal(day) {
  state.selectedDayNumber = day;
  const monthData = getCurrentMonthAttendance();
  const record = monthData.days[day] || { status: "work", overtime: 0, trips: "", notes: "" };

  const dateObj = new Date(state.currentYear, state.currentMonth, day);
  const dayName = getDayName(dateObj.getDay());
  const monthName = getMonthName(state.currentMonth);

  document.getElementById("modalDayTitle").textContent = `${dayName} ${day} ${monthName} ${state.currentYear}`;

  const radios = document.querySelectorAll("input[name='dayStatus']");
  radios.forEach(r => {
    r.checked = (r.value === (record.status || "work"));
  });

  document.getElementById("inputDayOvertime").value = record.overtime || 0;
  document.getElementById("inputDayTrips").value = record.trips || "";
  document.getElementById("inputDayNotes").value = record.notes || "";

  document.getElementById("dayDetailsModal").classList.add("active");
}

function closeDayModal() {
  document.getElementById("dayDetailsModal").classList.remove("active");
  state.selectedDayNumber = null;
}

function saveDayModal() {
  if (!state.selectedDayNumber) return;
  const day = state.selectedDayNumber;
  const monthData = getCurrentMonthAttendance();

  const selectedStatusRadio = document.querySelector("input[name='dayStatus']:checked");
  const status = selectedStatusRadio ? selectedStatusRadio.value : "work";
  const overtime = parseFloat(document.getElementById("inputDayOvertime").value) || 0;
  const trips = document.getElementById("inputDayTrips").value.trim();
  const notes = document.getElementById("inputDayNotes").value.trim();

  monthData.days[day] = {
    status,
    overtime,
    trips,
    notes
  };

  saveAttendanceToLocalStorage();
  closeDayModal();
  renderAttendanceView();
  showToast(t("saveSuccess"), "success");
}

// Quick Fill Attendance
function openQuickFillModal() {
  document.getElementById("quickFillModal").classList.add("active");
}

function closeQuickFillModal() {
  document.getElementById("quickFillModal").classList.remove("active");
}

function applyQuickFillPattern() {
  const selectedPattern = document.querySelector("input[name='fillPattern']:checked")?.value;
  if (!selectedPattern) return;

  const monthData = getCurrentMonthAttendance();
  const daysInMonth = new Date(state.currentYear, state.currentMonth + 1, 0).getDate();

  for (let day = 1; day <= daysInMonth; day++) {
    const dateObj = new Date(state.currentYear, state.currentMonth, day);
    const jsDay = dateObj.getDay();

    let status = "work";
    if (selectedPattern === "one_on_one_off") {
      // 1. يوم بيوم: يوم عمل يليه يوم راحة (الأيام الفردية عمل، الزوجية راحة)
      status = (day % 2 === 1) ? "work" : "rest";
    } else if (selectedPattern === "friday_off") {
      // 2. العمل طيلة الأسبوع مع راحة يوم الجمعة
      status = (jsDay === 5) ? "rest" : "work";
    } else if (selectedPattern === "two_on_one_off") {
      // 3. يومان عمل ثم يوم راحة (2 عمل ثم 1 راحة)
      status = (day % 3 === 0) ? "rest" : "work";
    } else if (selectedPattern === "one_on_two_off") {
      // 4. يوم عمل ويومان راحة (1 عمل ثم 2 راحة)
      status = (day % 3 === 1) ? "work" : "rest";
    } else if (selectedPattern === "all_work") {
      // 5. عمل كل الشهر
      status = "work";
    }

    if (!monthData.days[day]) {
      monthData.days[day] = { status, overtime: 0, trips: "", notes: "" };
    } else {
      monthData.days[day].status = status;
    }
  }

  saveAttendanceToLocalStorage();
  closeQuickFillModal();
  renderAttendanceView();
  showToast("تم تطبيق نظام العمل على جدول الشهر بنجاح!");
}

// --- 13. Tab 5: Fleet & Drivers Management ---
function renderFleetView() {
  const tbody = document.getElementById("fleetTableBody");
  if (!tbody) return;
  tbody.innerHTML = "";

  state.drivers.forEach(driver => {
    const is50 = driver.busType === "50_seater" || Number(driver.capacity) === 50;
    const status = driver.status || "active";
    let statusBadge = '<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-bold bg-emerald-100 text-emerald-800">🟢 نشط</span>';
    if (status === 'leave') {
      statusBadge = '<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-800">🔵 عطلة</span>';
    } else if (status === 'suspended') {
      statusBadge = '<span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-bold bg-rose-100 text-rose-800">🔴 موقف</span>';
    }

    const tr = document.createElement("tr");
    tr.className = "border-b border-slate-200 hover:bg-slate-50 transition-colors text-sm";
    tr.innerHTML = `
      <td class="py-3 px-3 font-bold text-slate-800">
        ${driver.name}
        ${driver.notes ? `<span class="block text-[11px] text-slate-400 font-normal">${driver.notes}</span>` : ''}
      </td>
      <td class="py-3 px-3 text-center whitespace-nowrap">${statusBadge}</td>
      <td class="py-3 px-3 font-mono text-slate-700 whitespace-nowrap">
        🚌 ${driver.busNumber || "-"}
        <span class="inline-flex items-center px-1.5 py-0.5 rounded text-[11px] font-semibold ${is50 ? 'bg-blue-100 text-blue-800 border border-blue-200 ms-1' : 'bg-slate-100 text-slate-700 ms-1'}">
          ${is50 ? '50 مقعد' : `${driver.capacity || 30} مقعد`}
        </span>
      </td>
      <td class="py-3 px-3 text-slate-600 text-xs">${driver.route || "-"}</td>
      <td class="py-3 px-3 text-slate-600 font-mono text-xs whitespace-nowrap">
        ${driver.phone || "-"}
        ${driver.license ? `<span class="block text-[10px] text-slate-400 font-sans">${driver.license}</span>` : ''}
      </td>
      <td class="py-3 px-3 font-mono font-semibold text-slate-800 whitespace-nowrap">${formatCurrency(driver.dailyWage || 0)}</td>
      <td class="py-3 px-3 font-mono font-semibold text-purple-700 whitespace-nowrap">${formatCurrency(driver.overtimeRate || 0)}</td>
      <td class="py-3 px-3 text-center whitespace-nowrap">
        <div class="flex items-center justify-center gap-1">
          <button class="btn-edit-driver-row p-1.5 hover:bg-slate-200 rounded text-slate-600 hover:text-blue-600" data-id="${driver.id}" title="تعديل">✏️</button>
          ${state.drivers.length > 1 ? `<button class="btn-del-driver-row p-1.5 hover:bg-rose-100 rounded text-slate-600 hover:text-rose-600" data-id="${driver.id}" title="حذف">🗑️</button>` : ''}
        </div>
      </td>
    `;
    tbody.appendChild(tr);
  });

  tbody.querySelectorAll(".btn-edit-driver-row").forEach(btn => {
    btn.addEventListener("click", () => {
      const driver = state.drivers.find(d => d.id === btn.dataset.id);
      if (driver) openDriversModal(driver);
    });
  });

  tbody.querySelectorAll(".btn-del-driver-row").forEach(btn => {
    btn.addEventListener("click", () => {
      deleteDriver(btn.dataset.id);
    });
  });
}

function openDriversModal(driverToEdit = null) {
  const formTitle = document.getElementById("driverFormTitle");
  const formId = document.getElementById("driverFormId");
  const btnCancelEdit = document.getElementById("btnCancelEditDriver");

  if (driverToEdit) {
    formTitle.textContent = "تعديل بيانات السائق";
    formId.value = driverToEdit.id;
    document.getElementById("driverNameInput").value = driverToEdit.name;
    document.getElementById("driverBusInput").value = driverToEdit.busNumber || "";
    document.getElementById("driverCapacityInput").value = driverToEdit.capacity || 50;
    document.getElementById("driverIs50Input").checked = (driverToEdit.busType === "50_seater" || driverToEdit.capacity === 50);
    document.getElementById("driverPhoneInput").value = driverToEdit.phone || "";
    document.getElementById("driverDailyWageInput").value = driverToEdit.dailyWage || 0;
    document.getElementById("driverOvertimeRateInput").value = driverToEdit.overtimeRate || 0;
    
    // New driver options
    document.getElementById("driverStatusInput").value = driverToEdit.status || "active";
    document.getElementById("driverRouteInput").value = driverToEdit.route || "";
    document.getElementById("driverLicenseInput").value = driverToEdit.license || "";
    document.getElementById("driverNotesInput").value = driverToEdit.notes || "";

    btnCancelEdit.style.display = "inline-flex";
  } else {
    resetDriverForm();
  }

  document.getElementById("driversModal").classList.add("active");
}

function closeDriversModal() {
  document.getElementById("driversModal").classList.remove("active");
  resetDriverForm();
}

function resetDriverForm() {
  document.getElementById("driverFormTitle").textContent = "إضافة سائق جديد";
  document.getElementById("driverFormId").value = "";
  document.getElementById("driverNameInput").value = "";
  document.getElementById("driverBusInput").value = "";
  document.getElementById("driverCapacityInput").value = "50";
  document.getElementById("driverIs50Input").checked = true;
  document.getElementById("driverPhoneInput").value = "";
  document.getElementById("driverDailyWageInput").value = "2800";
  document.getElementById("driverOvertimeRateInput").value = "450";

  // New driver options reset
  document.getElementById("driverStatusInput").value = "active";
  document.getElementById("driverRouteInput").value = "";
  document.getElementById("driverLicenseInput").value = "";
  document.getElementById("driverNotesInput").value = "";

  document.getElementById("btnCancelEditDriver").style.display = "none";
}

function saveDriver(e) {
  e.preventDefault();
  const id = document.getElementById("driverFormId").value;
  const name = document.getElementById("driverNameInput").value.trim();
  const busNumber = document.getElementById("driverBusInput").value.trim();
  const is50 = document.getElementById("driverIs50Input").checked;
  const capacity = Number(document.getElementById("driverCapacityInput").value) || (is50 ? 50 : 30);
  const phone = document.getElementById("driverPhoneInput").value.trim();
  const dailyWage = parseFloat(document.getElementById("driverDailyWageInput").value) || 0;
  const overtimeRate = parseFloat(document.getElementById("driverOvertimeRateInput").value) || 0;

  // New driver options values
  const status = document.getElementById("driverStatusInput").value;
  const route = document.getElementById("driverRouteInput").value.trim();
  const license = document.getElementById("driverLicenseInput").value.trim();
  const notes = document.getElementById("driverNotesInput").value.trim();

  if (!name) {
    alert("يرجى إدخال اسم السائق");
    return;
  }

  if (id) {
    const driver = state.drivers.find(d => d.id === id);
    if (driver) {
      driver.name = name;
      driver.busNumber = busNumber;
      driver.busType = is50 ? "50_seater" : "standard";
      driver.capacity = capacity;
      driver.phone = phone;
      driver.dailyWage = dailyWage;
      driver.overtimeRate = overtimeRate;
      driver.status = status;
      driver.route = route;
      driver.license = license;
      driver.notes = notes;
    }
  } else {
    const newId = "drv_" + Date.now();
    state.drivers.push({
      id: newId,
      name,
      busNumber,
      busType: is50 ? "50_seater" : "standard",
      capacity,
      phone,
      dailyWage,
      overtimeRate,
      status,
      route,
      license,
      notes,
      active: true
    });
    state.currentDriverId = newId;
  }

  saveDriversToLocalStorage();
  saveActiveDriverToLocalStorage();
  closeDriversModal();
  renderDriverSelect();
  renderTripsFilterOptions();
  renderFleetView();
  if (state.activeTab === "attendance") renderAttendanceView();
  showToast("تم حفظ بيانات السائق بنجاح!");
}

function deleteDriver(id) {
  if (state.drivers.length <= 1) {
    alert(state.lang === "ar" ? "يجب أن يبقى سائق واحد على الأقل في البرنامج." : "At least one driver must remain.");
    return;
  }

  const driver = state.drivers.find(d => d.id === id);
  if (!confirm(`${t("confirmDelete")} (${driver?.name})`)) {
    return;
  }

  state.drivers = state.drivers.filter(d => d.id !== id);
  if (state.currentDriverId === id) {
    state.currentDriverId = state.drivers[0].id;
  }

  saveDriversToLocalStorage();
  saveActiveDriverToLocalStorage();
  renderDriverSelect();
  renderTripsFilterOptions();
  renderFleetView();
  showToast(t("deleteSuccess"), "success");
}

// --- 14. Print Area & PDF Preparation ---
function prepareAndPrintReport() {
  const driver = getCurrentDriver();
  if (!driver) return;

  const monthData = getCurrentMonthAttendance();
  const year = state.currentYear;
  const month = state.currentMonth;
  const monthName = getMonthName(month);
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  document.getElementById("printMonthYear").textContent = `${state.lang === 'ar' ? 'لشهر:' : 'For Month:'} ${monthName} ${year}`;
  document.getElementById("printCurrentDate").textContent = new Date().toLocaleDateString(state.lang === 'ar' ? 'ar-DZ' : 'en-US');
  document.getElementById("printDriverName").textContent = driver.name;
  document.getElementById("printBusNumber").textContent = driver.busNumber || "-";
  document.getElementById("printDriverPhone").textContent = driver.phone || "-";
  document.getElementById("printDailyWage").textContent = formatCurrency(driver.dailyWage || 0);
  document.getElementById("printOvertimeRate").textContent = formatCurrency(driver.overtimeRate || 0);

  const printTableBody = document.getElementById("printTableBody");
  printTableBody.innerHTML = "";

  let workDays = 0, restDays = 0, absenceDays = 0, totalOvertime = 0;

  for (let day = 1; day <= daysInMonth; day++) {
    const dateObj = new Date(year, month, day);
    const dayName = getDayName(dateObj.getDay());
    const record = monthData.days[day] || { status: "work", overtime: 0, trips: "", notes: "" };

    const status = record.status || "work";
    let statusText = t("statusWork");
    if (status === "rest") { statusText = t("statusRest"); restDays++; }
    else if (status === "absence") { statusText = t("statusAbsence"); absenceDays++; }
    else if (status === "leave") { statusText = t("statusLeave"); }
    else { workDays++; }

    const ot = Number(record.overtime || 0);
    if (ot > 0) totalOvertime += ot;

    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${day}</td>
      <td>${dayName}</td>
      <td>${statusText}</td>
      <td>${ot > 0 ? ot : '-'}</td>
      <td>${record.trips || '-'}</td>
      <td>${record.notes || '-'}</td>
    `;
    printTableBody.appendChild(tr);
  }

  const baseSalary = workDays * Number(driver.dailyWage || 0);
  const overtimeSalary = totalOvertime * Number(driver.overtimeRate || 0);
  const bonus = Number(monthData.bonus || 0);
  const deduction = Number(monthData.deduction || 0);
  const netTotal = Math.max(0, baseSalary + overtimeSalary + bonus - deduction);

  document.getElementById("printSumWorkDays").textContent = workDays;
  document.getElementById("printSumRestDays").textContent = restDays;
  document.getElementById("printSumAbsenceDays").textContent = absenceDays;
  document.getElementById("printSumOvertime").textContent = totalOvertime;

  document.getElementById("printSumBaseSalary").textContent = formatCurrency(baseSalary);
  document.getElementById("printSumOvertimeSalary").textContent = formatCurrency(overtimeSalary);
  document.getElementById("printSumBonus").textContent = formatCurrency(bonus);
  document.getElementById("printSumDeductions").textContent = formatCurrency(deduction);
  document.getElementById("printSumNetTotal").textContent = formatCurrency(netTotal);

  window.print();
}

// --- 15. Backup and Restore (JSON) ---
function exportBackup() {
  const backupData = {
    version: "2.0",
    exportDate: new Date().toISOString(),
    lang: state.lang,
    drivers: state.drivers,
    trips: state.trips,
    attendanceData: state.attendanceData
  };

  const jsonStr = JSON.stringify(backupData, null, 2);
  const blob = new Blob([jsonStr], { type: "application/json;charset=utf-8;" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.setAttribute("href", url);
  link.setAttribute("download", `bus_tracker_backup_${new Date().toISOString().slice(0, 10)}.json`);
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  showToast(state.lang === "ar" ? "تم تصدير النسخة الاحتياطية بنجاح!" : "Backup downloaded successfully!");
}

function importBackup(file) {
  if (!file) return;
  const reader = new FileReader();
  reader.onload = (e) => {
    try {
      const data = JSON.parse(e.target.result);
      if (data.drivers && Array.isArray(data.drivers)) {
        state.drivers = data.drivers;
        if (Array.isArray(data.trips)) state.trips = data.trips;
        if (data.attendanceData) state.attendanceData = data.attendanceData;
        
        state.currentDriverId = state.drivers[0]?.id || null;
        saveDriversToLocalStorage();
        saveTripsToLocalStorage();
        saveAttendanceToLocalStorage();
        saveActiveDriverToLocalStorage();
        
        renderDriverSelect();
        renderTripsFilterOptions();
        renderActiveTab();
        showToast(state.lang === "ar" ? "تم استيراد واسترجاع البيانات بنجاح!" : "Data restored successfully!");
      } else {
        alert(state.lang === "ar" ? "الملف غير صالح أو لا يحتوي على بنية بيانات صحيحة." : "Invalid backup file structure.");
      }
    } catch (err) {
      alert("Error: " + err.message);
    }
  };
// --- 15.5 Customer Bookings & Overflow Dispatch Logic ---
function getStoredBookings() {
  try {
    const raw = localStorage.getItem("bus_tracker_bookings");
    if (raw) return JSON.parse(raw);
  } catch (e) {
    console.error(e);
  }
  return [
    {
      id: "BK-101",
      name: "فوج طلبة الجامعة",
      phone: "0550112233",
      routeId: "route_1",
      routeName: "الخط 01: المحطة المركزية ➔ الجامعة المركزية",
      date: new Date().toISOString().slice(0, 10),
      seats: 48,
      assignedBus: "12",
      originalBus: "12",
      isOverflow: false,
      notes: "حجز جماعي مسبق",
      timestamp: new Date().toLocaleString('ar-DZ')
    },
    {
      id: "BK-102",
      name: "أحمد بن عيسى",
      phone: "0661223344",
      routeId: "route_1",
      routeName: "الخط 01: المحطة المركزية ➔ الجامعة المركزية",
      date: new Date().toISOString().slice(0, 10),
      seats: 4,
      assignedBus: "08",
      originalBus: "12",
      isOverflow: true,
      notes: "تم التحويل التلقائي للحافلة البديلة 08 نظراً لاكتمال مقاعد الحافلة 12",
      timestamp: new Date().toLocaleString('ar-DZ')
    }
  ];
}

function saveStoredBookings(bookings) {
  localStorage.setItem("bus_tracker_bookings", JSON.stringify(bookings));
}

function renderBookingsView() {
  const bookings = getStoredBookings();
  const container = document.getElementById("adminBookingsTableBody");
  const cardsGrid = document.getElementById("busOccupancyCardsGrid");
  const searchQuery = (document.getElementById("filterAdminBookingSearch")?.value || "").trim().toLowerCase();

  // 1. Render Occupancy Cards per Bus
  if (cardsGrid) {
    cardsGrid.innerHTML = "";
    const buses = [
      { number: "12", capacity: 50, route: "الخط 01: المحطة ➔ الجامعة" },
      { number: "08", capacity: 50, route: "الخط 02: وسط المدينة ➔ حي النور" },
      { number: "19", capacity: 50, route: "الخط 03: المطار ➔ المحطة الكبرى" },
      { number: "04", capacity: 30, route: "الخط 04: خط النقل التكميلي" }
    ];

    buses.forEach(bus => {
      const bookedCount = bookings
        .filter(b => b.assignedBus === bus.number)
        .reduce((sum, b) => sum + (Number(b.seats) || 1), 0);
      const isFull = bookedCount >= bus.capacity;
      const pct = Math.min(100, Math.round((bookedCount / bus.capacity) * 100));

      const card = document.createElement("div");
      card.className = `p-4 rounded-2xl border transition-all ${isFull ? 'bg-rose-50 border-rose-200' : 'bg-white border-slate-200 shadow-xs'}`;
      card.innerHTML = `
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-2">
            <span class="text-xl">🚌</span>
            <span class="font-black text-slate-800 text-sm">حافلة رقم ${bus.number}</span>
          </div>
          <span class="px-2 py-0.5 rounded-full text-[10px] font-bold ${isFull ? 'bg-rose-100 text-rose-800' : 'bg-emerald-100 text-emerald-800'}">
            ${isFull ? '🔴 ممتلئة تماماً' : '🟢 مقاعد متوفرة'}
          </span>
        </div>
        <p class="text-[11px] text-slate-500 mt-1 truncate">${bus.route}</p>
        <div class="mt-3">
          <div class="flex items-center justify-between text-xs font-bold mb-1">
            <span class="text-slate-600">المحجوز: ${bookedCount} / ${bus.capacity}</span>
            <span class="${isFull ? 'text-rose-700 font-black' : 'text-blue-700'}">${pct}%</span>
          </div>
          <div class="w-full bg-slate-100 rounded-full h-2 overflow-hidden">
            <div class="h-full rounded-full transition-all ${isFull ? 'bg-rose-500' : pct >= 80 ? 'bg-amber-500' : 'bg-blue-600'}" style="width: ${pct}%"></div>
          </div>
        </div>
        ${isFull ? `
          <div class="mt-2.5 p-1.5 bg-rose-100/70 rounded-lg text-[10px] text-rose-900 font-bold flex items-center gap-1">
            <span>⚠️</span>
            <span>الحافلة ممتلئة! الحجز يحوّل للحافلة البديلة</span>
          </div>
        ` : ''}
      `;
      cardsGrid.appendChild(card);
    });
  }

  // 2. Render Bookings Table
  if (container) {
    container.innerHTML = "";

    const filtered = bookings.filter(b => {
      if (!searchQuery) return true;
      return (b.name && b.name.toLowerCase().includes(searchQuery)) ||
             (b.id && b.id.toLowerCase().includes(searchQuery)) ||
             (b.phone && b.phone.includes(searchQuery)) ||
             (b.assignedBus && b.assignedBus.includes(searchQuery));
    });

    if (filtered.length === 0) {
      container.innerHTML = `
        <tr>
          <td colspan="9" class="py-8 text-center text-slate-400 text-xs">
            لا توجد حجوزات تطابق البحث.
          </td>
        </tr>
      `;
      return;
    }

    filtered.forEach(b => {
      const tr = document.createElement("tr");
      tr.className = "border-b border-slate-200 hover:bg-slate-50 transition-colors text-sm";
      tr.innerHTML = `
        <td class="py-3 px-3 font-mono font-bold text-blue-700 whitespace-nowrap">${b.id}</td>
        <td class="py-3 px-3 font-bold text-slate-800">
          ${b.name}
          ${b.notes && b.notes !== 'لا توجد ملاحظات' ? `<span class="block text-[11px] text-slate-400 font-normal">${b.notes}</span>` : ''}
        </td>
        <td class="py-3 px-3 font-mono text-slate-600 whitespace-nowrap" dir="ltr">${b.phone || '-'}</td>
        <td class="py-3 px-3 text-slate-700 text-xs">${b.routeName || '-'}</td>
        <td class="py-3 px-3 font-mono text-xs text-slate-600 whitespace-nowrap">${b.date}</td>
        <td class="py-3 px-3 text-center font-bold text-slate-800">${b.seats || 1}</td>
        <td class="py-3 px-3 text-center font-mono font-bold text-slate-800 whitespace-nowrap">
          🚌 حافلة ${b.assignedBus}
        </td>
        <td class="py-3 px-3 text-center whitespace-nowrap">
          ${b.isOverflow ? `
            <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-bold bg-amber-100 text-amber-900 border border-amber-300" title="تم التحويل بسبب امتلاء حافلة ${b.originalBus}">
              <span>🔄 حافلة بديلة</span>
              <span class="text-[10px] text-amber-700">(امتلاء ${b.originalBus})</span>
            </span>
          ` : `
            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-bold bg-emerald-100 text-emerald-800">
              🟢 حافلة أساسية
            </span>
          `}
        </td>
        <td class="py-3 px-3 text-center whitespace-nowrap">
          <button class="btn-del-booking p-1.5 hover:bg-rose-100 text-slate-500 hover:text-rose-600 rounded-lg transition-colors" data-id="${b.id}" title="إلغاء وحذف التذكرة">
            🗑️
          </button>
        </td>
      `;
      container.appendChild(tr);
    });

    container.querySelectorAll(".btn-del-booking").forEach(btn => {
      btn.addEventListener("click", () => {
        const id = btn.dataset.id;
        if (confirm(`هل تريد بالتأكيد إلغاء وحذف الحجز رقم ${id}؟`)) {
          const current = getStoredBookings();
          const updated = current.filter(x => x.id !== id);
          saveStoredBookings(updated);
          renderBookingsView();
          showToast("تم إلغاء وحذف التذكرة بنجاح!");
        }
      });
    });
  }
}

// --- 16. Event Listeners Setup ---
function setupEventListeners() {
  // Navigation Tabs (Desktop & Android Bottom Bar)
  document.querySelectorAll(".nav-tab-btn, .android-bottom-nav-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      switchTab(btn.dataset.tab);
    });
  });

  // Driver Select in Attendance
  const driverSelect = document.getElementById("driverSelect");
  if (driverSelect) {
    driverSelect.addEventListener("change", (e) => {
      state.currentDriverId = e.target.value;
      saveActiveDriverToLocalStorage();
      renderAttendanceView();
    });
  }

  // Month Navigation
  document.getElementById("btnPrevMonth")?.addEventListener("click", () => {
    if (state.currentMonth === 0) {
      state.currentMonth = 11;
      state.currentYear--;
    } else {
      state.currentMonth--;
    }
    renderActiveTab();
  });

  document.getElementById("btnNextMonth")?.addEventListener("click", () => {
    if (state.currentMonth === 11) {
      state.currentMonth = 0;
      state.currentYear++;
    } else {
      state.currentMonth++;
    }
    renderActiveTab();
  });

  document.getElementById("btnToday")?.addEventListener("click", () => {
    const today = new Date();
    state.currentYear = today.getFullYear();
    state.currentMonth = today.getMonth();
    renderActiveTab();
  });

  // Month Navigation in Reports Tab
  document.getElementById("btnPrevMonthReport")?.addEventListener("click", () => {
    if (state.currentMonth === 0) {
      state.currentMonth = 11;
      state.currentYear--;
    } else {
      state.currentMonth--;
    }
    renderMonthlyReports();
  });

  document.getElementById("btnNextMonthReport")?.addEventListener("click", () => {
    if (state.currentMonth === 11) {
      state.currentMonth = 0;
      state.currentYear++;
    } else {
      state.currentMonth++;
    }
    renderMonthlyReports();
  });

  // Trip Filters
  document.getElementById("filterTripSearch")?.addEventListener("input", (e) => {
    state.tripFilters.search = e.target.value.trim();
    renderTripsTable();
  });

  document.getElementById("filterTripDriver")?.addEventListener("change", (e) => {
    state.tripFilters.driverId = e.target.value;
    renderTripsTable();
  });

  document.getElementById("filterTripBusType")?.addEventListener("change", (e) => {
    state.tripFilters.busType = e.target.value;
    renderTripsTable();
  });

  document.getElementById("filterTripStatus")?.addEventListener("change", (e) => {
    state.tripFilters.status = e.target.value;
    renderTripsTable();
  });

  // Trip Actions & Modal
  document.getElementById("btnOpenAddTripModal")?.addEventListener("click", () => openTripModal());
  document.getElementById("btnDashAddTrip")?.addEventListener("click", () => openTripModal());
  document.getElementById("androidFabAddTrip")?.addEventListener("click", () => openTripModal());
  document.getElementById("btnCloseTripModal")?.addEventListener("click", closeTripModal);
  document.getElementById("btnCancelTripModal")?.addEventListener("click", closeTripModal);
  document.getElementById("tripForm")?.addEventListener("submit", handleSaveTrip);

  // Bonus & Deduction in Attendance
  document.getElementById("inputBonus")?.addEventListener("input", (e) => {
    const monthData = getCurrentMonthAttendance();
    monthData.bonus = parseFloat(e.target.value) || 0;
    saveAttendanceToLocalStorage();
    updateStatisticsAndFinance();
  });

  document.getElementById("inputDeduction")?.addEventListener("input", (e) => {
    const monthData = getCurrentMonthAttendance();
    monthData.deduction = parseFloat(e.target.value) || 0;
    saveAttendanceToLocalStorage();
    updateStatisticsAndFinance();
  });

  // Attendance Day Modal
  document.getElementById("btnCloseDayModal")?.addEventListener("click", closeDayModal);
  document.getElementById("btnCancelDayModal")?.addEventListener("click", closeDayModal);
  document.getElementById("btnSaveDayModal")?.addEventListener("click", saveDayModal);

  // Quick Fill Modal
  document.getElementById("btnQuickFillModal")?.addEventListener("click", openQuickFillModal);
  document.getElementById("btnCloseQuickFillModal")?.addEventListener("click", closeQuickFillModal);
  document.getElementById("btnCancelQuickFill")?.addEventListener("click", closeQuickFillModal);
  document.getElementById("btnApplyQuickFill")?.addEventListener("click", applyQuickFillPattern);

  // Reset Month
  document.getElementById("btnResetMonth")?.addEventListener("click", () => {
    if (confirm(state.lang === "ar" ? "هل تريد بالتأكيد إعادة ضبط وتفريغ جدول هذا الشهر؟" : "Clear this month's attendance table?")) {
      const key = getMonthKey();
      state.attendanceData[key] = { days: {}, bonus: 0, deduction: 0 };
      saveAttendanceToLocalStorage();
      renderAttendanceView();
    }
  });

  // Drivers Management
  document.getElementById("btnManageDrivers")?.addEventListener("click", () => openDriversModal());
  document.getElementById("btnFleetAddDriver")?.addEventListener("click", () => openDriversModal());
  document.getElementById("btnQuickAddDriver")?.addEventListener("click", () => openDriversModal());
  document.getElementById("btnEditCurrentDriverFinance")?.addEventListener("click", () => {
    const current = getCurrentDriver();
    if (current) openDriversModal(current);
  });
  document.getElementById("btnCloseDriversModal")?.addEventListener("click", closeDriversModal);
  document.getElementById("btnFinishDriversModal")?.addEventListener("click", closeDriversModal);
  document.getElementById("btnCancelEditDriver")?.addEventListener("click", resetDriverForm);
  document.getElementById("driverForm")?.addEventListener("submit", saveDriver);

  // Printing & Excel Exports
  document.getElementById("btnPrintReport")?.addEventListener("click", prepareAndPrintReport);
  document.getElementById("btnExportReportCSV")?.addEventListener("click", exportMonthlyReportToCSV);

  // Backup & Restore
  document.getElementById("btnBackupData")?.addEventListener("click", exportBackup);
  document.getElementById("btnRestoreData")?.addEventListener("click", () => {
    document.getElementById("fileRestoreInput")?.click();
  });
  document.getElementById("fileRestoreInput")?.addEventListener("change", (e) => {
    const file = e.target.files[0];
    if (file) {
      importBackup(file);
      e.target.value = "";
    }
  });

  // Booking Portal Modal & Link Actions
  const bookingModal = document.getElementById("bookingModal");
  document.getElementById("btnOpenBookingModal")?.addEventListener("click", () => {
    bookingModal?.classList.add("active");
  });
  document.getElementById("btnCloseBookingModal")?.addEventListener("click", () => {
    bookingModal?.classList.remove("active");
  });
  document.getElementById("btnFinishBookingModal")?.addEventListener("click", () => {
    bookingModal?.classList.remove("active");
  });

  // Copy Booking URL function
  function copyBookingUrl(btnId) {
    const btn = document.getElementById(btnId);
    const fullUrl = window.location.origin ? `${window.location.origin}${window.location.pathname.replace('index.html', '')}booking.html` : "booking.html";
    navigator.clipboard.writeText(fullUrl).then(() => {
      showToast("تم نسخ رابط الحجز المباشر للزبائن بنجاح!");
      if (btn) {
        const origText = btn.innerHTML;
        btn.innerHTML = "✅ تم النسخ!";
        setTimeout(() => { btn.innerHTML = origText; }, 2000);
      }
    }).catch(() => {
      prompt("انسخ رابط الحجز التالي:", fullUrl);
    });
  }

  document.getElementById("btnCopyBookingUrlModal")?.addEventListener("click", () => copyBookingUrl("btnCopyBookingUrlModal"));
  document.getElementById("btnCopyBookingLinkInTab")?.addEventListener("click", () => copyBookingUrl("btnCopyBookingLinkInTab"));

  // Filter Bookings Search Input
  document.getElementById("filterAdminBookingSearch")?.addEventListener("input", () => {
    renderBookingsView();
  });

  // Close modals on clicking backdrop
  window.addEventListener("click", (e) => {
    if (e.target.classList.contains("modal-backdrop")) {
      e.target.classList.remove("active");
    }
  });
}

// --- 17. Initialization ---
document.addEventListener("DOMContentLoaded", () => {
  loadFromLocalStorage();
  setLanguage(state.lang);
  setupEventListeners();
  renderDriverSelect();
  renderTripsFilterOptions();
  switchTab("dashboard");
});
