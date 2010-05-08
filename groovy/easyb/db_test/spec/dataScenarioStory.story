
import java.sql.DriverManager
import groovy.sql.Sql
import groovy.xml.MarkupBuilder

import org.dbunit.dataset.xml.FlatXmlDataSet
import org.disco.easyb.plugin.delegates.DBUnitDelegate

import sample.DataDao

//HSQLDB �ɓ��{����i�[�����邽�߂̑[�u
DBUnitDelegate.metaClass.getDataSet = {Closure model ->
	data = model.call() as String
	new FlatXmlDataSet(new ByteArrayInputStream(data.getBytes("UTF-8")))
}

dburl = "jdbc:hsqldb:./db/test1"
driver = "org.hsqldb.jdbcDriver"
user = "sa"
password = ""

scenario "�f�[�^����������", {

	given "DB�X�L�[�}��`", {
		sql = Sql.newInstance(dburl, user, password, driver)
		ddl = """
		      DROP TABLE data IF EXISTS;
              CREATE TABLE data(ID INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, NAME VARCHAR(50), POINT INTEGER NOT NULL);
              COMMIT;
              """
		sql.execute(ddl)
	}

    and "�����f�[�^", {
		database_model(driver, dburl, user, password) {
			def writer = new StringWriter()
			def builder = new MarkupBuilder(writer)

			builder.dataset() {
				data(name: "�e�X�^�[1", point: 10)
				data(name: "fits", point: 5)
			}

			writer.toString()
		}
    }

	when "DB�����N���X�̃C���X�^���X�쐬", {
		dbObj = new DataDao(DriverManager.getConnection(dburl, user, password))
	}

    then "test1 �̌������ʐ��� 1 �ɂȂ�͂�", {
		resultList = dbObj.searchWithName("�e�X�^�[1")
		resultList.size.shouldBe 1
    }

	and "id �� 1�Apoint �� 10 �ɂȂ�͂�", {
		resultList[0].id.shouldBe 1
		resultList[0].point.shouldBe 10
	}
}