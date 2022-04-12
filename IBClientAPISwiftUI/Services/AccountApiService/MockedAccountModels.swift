//
//  MockedAccountModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation


enum MockedAccountModels {
    static let account: [Account] = Bundle.main.decode(type: [Account].self, from: "AccountResponse.json")
    
    static let performanceResponse: PerformanceResponse = Bundle.main.decode(type: PerformanceResponse.self, from: "PerformanceResponse.json")
    
    static let allocationResponse: AllocationResponse = Bundle.main.decode(type: AllocationResponse.self, from: "AccountAllocation.json")
    
    static let accountSumary: AccountSummary = Bundle.main.decode(type: AccountSummary.self, from: "AccountSummary.json")
    
    static let pnlModelResponse: PnLModelResponseModel = Bundle.main.decode(type: PnLModelResponseModel.self, from: "PnLResponse.json")
    
    static let tickleResponse: TickleResponse = Bundle.main.decode(type: TickleResponse.self, from: "TickleResponse.json")
    
    static let paSummaryResponse: PASummaryResponse = Bundle.main.decode(type: PASummaryResponse.self, from: "PaSummaryResponse.json")
    
    static let iServerResponse: IServerResponse = Bundle.main.decode(type: IServerResponse.self, from: "MockIServerResponse.json")
    
    static let mockedEvnironmentModel = EnvironmentModel(
        accountViewModel: AccountViewModel(
            repository: AccountRepository(
                apiService: MockAccountApiService(
                    accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
            )
        )
    )
    
    static let mockedAccountPerformance = AccountPerformance(
        graphData: [
            2018.9681, 1987.1973, 1978.8426, 1950.6803, 1948.8929, 1850.7427, 1841.4446, 1785.9329, 1752.0067, 1797.1987, 1771.6772, 1767.6911, 1751.5976, 1795.2381, 1782.3382, 1827.8959, 1817.3979, 1859.6844, 1880.9427, 1874.2774, 1867.4368, 1865.6159, 1856.6883, 1805.4166, 1840.365, 1839.215, 1838.9261, 1821.4111, 1829.2673, 1852.8746, 1894.8677, 1856.3377, 1877.0829, 1914.2822, 1922.0487, 1907.5485, 1908.5578, 1959.9836, 2002.6027, 1998.9526, 2040.1658, 2042.6989, 2046.646, 2044.1341, 2048.1638, 2049.081, 2039.7484, 2044.3484, 2042.1468, 2047.7076, 2089.2215, 2077.318, 2041.2138, 2035.2114, 2007.0502, 2007.2753, 2051.979, 2065.2128, 2037.0837, 2022.0324, 2041.1509, 2004.787, 1996.8906, 2034.4611, 2054.4769, 2088.5699, 2063.8764, 2067.5614, 2064.6831, 2077.0945, 2078.8266, 2082.7886, 2079.3849, 2076.8375, 2044.9079, 1967.9376, 1803.4896, 1801.0555, 1745.8463, 1800.7517, 1843.1235, 1879.0198, 1885.229, 1856.7811, 1891.0386, 1923.7988, 1904.8077, 1903.5633, 1909.6356, 1939.0561, 1942.1489, 1891.4782, 1826.1273, 1853.9527, 1782.5817, 1768.7677, 1749.1231, 1742.0022, 1710.1566, 1736.4536, 1596.1812, 1588.938, 1652.0271, 1690.8321, 1671.3106, 1665.2018, 1613.4732, 1586.3032, 1596.7371, 1648.3674, 1612.4461, 1645.2198, 1645.7529, 1662.7342, 1682.3083, 1689.1119, 1665.166, 1666.6437, 1668.0861, 1699.251, 1726.3679, 1752.2351, 1760.0765, 1774.0328, 1708.7816, 1744.6349, 1710.943, 1655.0964, 1706.295, 1692.5689, 1760.1436, 1838.7334, 1880.6333, 1942.1563, 1929.8047, 2026.2726, 2083.8884, 2011.6546, 2000.1537, 2052.6875, 2017.1793, 2005.1931, 1979.265, 1865.7123, 1905.8876, 1839.7388, 1899.1576, 1908.0857, 1912.0459, 1807.414, 1872.6322, 1817.052, 1795.6081, 1740.7495, 1567.6641, 1568.2637, 1630.3155, 1652.7002, 1560.5001, 1519.9445, 1450.8043, 1419.5954, 1429.6733, 1383.566, 1388.2645, 1338.8982, 1394.7868, 1396.3416, 1472.0299, 1470.731, 1478.9418, 1390.2977, 1347.5925, 1394.2028, 1366.5778, 1405.7138, 1402.3739, 1313.6103, 1275.6527, 1235.1218, 1222.4019, 1290.9399, 1309.0497, 1248.3755, 1258.3486, 1256.4673, 1210.8341, 1192.1169, 1204.958, 1119.9276, 1106.6406, 1098.8937, 1082.3159, 1025.6854, 1054.1999, 1111.1125, 1142.1825, 1098.8384, 1053.1514, 1103.5996, 1146.631, 1175.6254, 1211.3496, 1200.6356, 1144.6704, 1146.828, 1191.2689, 1203.2239, 1134.4121, 1103.4761, 1109.5344, 1075.8062, 1044.459, 1099.3326, 1079.9321, 1161.7903, 1200.2065, 1209.002, 1167.8528, 1124.6391, 1112.4475, 1102.0239, 1135.6145, 1093.9506, 1021.751, 979.9772, 1001.7818, 1059.7459, 1117.9061, 1175.0256, 1149.9507, 1166.8247, 1154.3434, 1192.428, 1132.212, 1176.8032, 1172.4078, 1131.2403, 1096.8123, 1105.5786, 1127.8347, 1084.3687, 1047.6962, 1039.9789, 1019.2102
    ],
        dates: [
            "21-05-03", "21-05-04", "21-05-05", "21-05-06", "21-05-07", "21-05-10", "21-05-11", "21-05-12", "21-05-13", "21-05-14", "21-05-17", "21-05-18", "21-05-19", "21-05-20", "21-05-21", "21-05-24", "21-05-25", "21-05-26", "21-05-27", "21-05-28", "21-05-31", "21-06-01", "21-06-02", "21-06-03", "21-06-04", "21-06-07", "21-06-08", "21-06-09", "21-06-10", "21-06-11", "21-06-14", "21-06-15", "21-06-16", "21-06-17", "21-06-18", "21-06-21", "21-06-22", "21-06-23", "21-06-24", "21-06-25", "21-06-28", "21-06-29", "21-06-30", "21-07-01", "21-07-02", "21-07-05", "21-07-06", "21-07-07", "21-07-08", "21-07-09", "21-07-12", "21-07-13", "21-07-14", "21-07-15", "21-07-16", "21-07-19", "21-07-20", "21-07-21", "21-07-22", "21-07-23", "21-07-26", "21-07-27", "21-07-28", "21-07-29", "21-07-30", "21-08-02", "21-08-03", "21-08-04", "21-08-05", "21-08-06", "21-08-09", "21-08-10", "21-08-11", "21-08-12", "21-08-13", "21-08-16", "21-08-17", "21-08-18", "21-08-19", "21-08-20", "21-08-23", "21-08-24", "21-08-25", "21-08-26", "21-08-27", "21-08-30", "21-08-31", "21-09-01", "21-09-02", "21-09-03", "21-09-06", "21-09-07", "21-09-08", "21-09-09", "21-09-10", "21-09-13", "21-09-14", "21-09-15", "21-09-16", "21-09-17", "21-09-20", "21-09-21", "21-09-22", "21-09-23", "21-09-24", "21-09-27", "21-09-28", "21-09-29", "21-09-30", "21-10-01", "21-10-04", "21-10-05", "21-10-06", "21-10-07", "21-10-08", "21-10-11", "21-10-12", "21-10-13", "21-10-14", "21-10-15", "21-10-18", "21-10-19", "21-10-20", "21-10-21", "21-10-22", "21-10-25", "21-10-26", "21-10-27", "21-10-28", "21-10-29", "21-11-01", "21-11-02", "21-11-03", "21-11-04", "21-11-05", "21-11-08", "21-11-09", "21-11-10", "21-11-11", "21-11-12", "21-11-15", "21-11-16", "21-11-17", "21-11-18", "21-11-19", "21-11-22", "21-11-23", "21-11-24", "21-11-25", "21-11-26", "21-11-29", "21-11-30", "21-12-01", "21-12-02", "21-12-03", "21-12-06", "21-12-07", "21-12-08", "21-12-09", "21-12-10", "21-12-13", "21-12-14", "21-12-15", "21-12-16", "21-12-17", "21-12-20", "21-12-21", "21-12-22", "21-12-23", "21-12-24", "21-12-27", "21-12-28", "21-12-29", "21-12-30", "21-12-31", "22-01-03", "22-01-04", "22-01-05", "22-01-06", "22-01-07", "22-01-10", "22-01-11", "22-01-12", "22-01-13", "22-01-14", "22-01-17", "22-01-18", "22-01-19", "22-01-20", "22-01-21", "22-01-24", "22-01-25", "22-01-26", "22-01-27", "22-01-28", "22-01-31", "22-02-01", "22-02-02", "22-02-03", "22-02-04", "22-02-07", "22-02-08", "22-02-09", "22-02-10", "22-02-11", "22-02-14", "22-02-15", "22-02-16", "22-02-17", "22-02-18", "22-02-21", "22-02-22", "22-02-23", "22-02-24", "22-02-25", "22-02-28", "22-03-01", "22-03-02", "22-03-03", "22-03-04", "22-03-07", "22-03-08", "22-03-09", "22-03-10", "22-03-11", "22-03-14", "22-03-15", "22-03-16", "22-03-17", "22-03-18", "22-03-21", "22-03-22", "22-03-23", "22-03-24", "22-03-25", "22-03-28", "22-03-29", "22-03-30", "22-03-31", "22-04-01", "22-04-04", "22-04-05", "22-04-06", "22-04-07", "22-04-08"
        ], moneyChange: -999.7579000000001, percentChange: 50.48173866640092)
}
