package de.womomo

import org.apache.poi.hssf.usermodel.HSSFWorkbook

class ExcelService {

    def importCampsites() {
        HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream("data/bordatlas2008.xls"))

        def sheet = workbook.getSheet("BORDATLAS")

        int rowNum = 1
        def row = sheet.getRow(rowNum)
        while (row) {
            try {
                def campsite = new Campsite()

                def cell = row.getCell(1)
                campsite.longitude = cell.getNumericCellValue()
                cell = row.getCell(2)
                campsite.latitude = cell.getNumericCellValue()
                cell = row.getCell(3)
                campsite.name = cell.getStringCellValue()?.replace("\"", "")
                campsite.save()
            }
            catch (NumberFormatException ex) {
                // ignore for now
            }

            row = sheet.getRow(++rowNum)
        }
    }
}
