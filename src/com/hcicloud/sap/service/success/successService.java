package com.hcicloud.sap.service.success;

import com.hcicloud.sap.pagemodel.base.Grid;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by songxueyan on 2016/12/15.
 */
@Service
public class successService {
    private static TransportClient client;
    private static String INDEX = "paingan2016-12";
    private static String TYPE = "success";
    private static String ADDRESS = "http://10.0.1.227";
    public static TransportClient init(){
        Settings settings = ImmutableSettings.settingsBuilder()
                .put("client.transport.sniff", true)
                .put("cluster.name", "cluster_name")
                .build();
        client = new TransportClient(settings).addTransportAddress(new InetSocketTransportAddress(ADDRESS,9200));
        return client;
    }

    public Grid getServiceList(){
        System.out.println("from size 模式启动！");
        Date begin = new Date();
        long count = client.prepareCount(INDEX).setTypes(TYPE).execute().actionGet().getCount();
        SearchRequestBuilder requestBuilder = client.prepareSearch(INDEX).setTypes(TYPE).setQuery(QueryBuilders.matchAllQuery());
        for(int i=0,sum=0; sum<count; i++){
            SearchResponse response = requestBuilder.setFrom(i).setSize(50000).execute().actionGet();
            sum += response.getHits().hits().length;
            System.out.println("总量"+count+" 已经查到"+sum);
        }
        Date end = new Date();
        System.out.println("耗时: "+(end.getTime()-begin.getTime()));
        return null;
    }
}
