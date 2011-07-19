package de.womomo

import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.grails.plugins.excelimport.ExcelImportUtils

class ExcelService {

  static transactional = true

  def importCampsites() {
    Map columnMap = [
            sheet: 'BORDATLAS',
            startRow: 2,
            columnMap: [
                    'B': 'longitude',
                    'C': 'latitude',
                    'D': 'name'
            ]
    ]

    HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream("data/bordatlas2008.xls"))
    List result = ExcelImportUtils.convertColumnMapConfigManyRows(workbook, columnMap)
    result.each { Map row ->
      try {
        def campsite = new Campsite()
        campsite.name = row.name.replace("\"", "")
        campsite.latitude = (row.latitude instanceof String ? row.latitude.trim().toDouble() : row.latitude)
        campsite.longitude = (row.longitude instanceof String ? row.longitude.trim().toDouble() : row.longitude)
        campsite.save()
      }
      catch (NumberFormatException ex) {
        // ignore for now
      }
    }
  }
}
