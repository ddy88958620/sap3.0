package com.hcicloud.sap.pagemodel.base;

import java.io.Serializable;

public class PageFilter implements Serializable {
	private int page;
	private int rows;
	private String sort;
	private String order;
	
	public PageFilter() {
		this.page = 1;
		this.rows = 1;
		this.sort = "id";
		this.order = "asc";
	}
	
	public PageFilter(int page, int rows) {
		this.page = page;
		this.rows = rows;
		this.sort = "id";
		this.order = "asc";
	}
	
	public PageFilter(int page, int rows, String sort, String order) {
		this.page = page;
		this.rows = rows;
		this.sort = sort;
		this.order = order;
	}

	public int getPage() {
		return this.page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return this.rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return this.sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return this.order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
 }
