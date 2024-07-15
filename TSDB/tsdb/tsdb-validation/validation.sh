EXTRA_LIBDIR=$NS_WDIR/webapps/DashboardServer/WEB-INF/lib/
THIRDPARTY_LIBDIR=$NS_WDIR/thirdparty/gui_signed_jars/
java -cp lib/tsdb-validation-1.0-SNAPSHOT.jar:${THIRDPARTY_LIBDIR}/snakeyaml-1.18.jar:$${EXTRA_LIBDIR}/java-getopt-1.0.9.jar:${THIRDPARTY_LIBDIR}/commons-io-2.4.jar:{EXTRA_LIBDIR}/log4j-core-2.17.1.jar:${EXTRA_LIBDIR}/log4j-api-2.17.1.jar:${EXTRA_LIBDIR}/CavNewTSDB-0.0.1.jar:${EXTRA_LIBDIR}/dashboard_rs.jar:${EXTRA_LIBDIR}/dashboardserver.jar:${EXTRA_LIBDIR}/log4j-1.2-api-2.17.1.jar:${EXTRA_LIBDIR}/commons-pool2-2.8.1.jar  com.cavisson.tsdb.validation.Main $@
