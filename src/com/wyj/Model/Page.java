package com.wyj.Model;

import java.util.List;

/**
 * Page是分页的模型对象
 * @param <T> 是具体模块的javabean
 */
public class Page<T> {
    public static final Integer PAGE_SIZE = 4;
    public static final Integer PAGE_LARGE_SIZE = 8;
    // 当前页码
    private long pageNo;
    // 总页码
    private long pageTotal;
    // 每页显示数量
    private long pageSize = PAGE_SIZE;
    // 总记录数
    private long recordCount;
    // long
    private List<T> items;

    public Page() {
    }

    public Page(long pageNo, long pageTotal, long pageSize, long recordCount, List<T> items) {
        this.pageNo = pageNo;
        this.pageTotal = pageTotal;
        this.pageSize = pageSize;
        this.recordCount = recordCount;
        this.items = items;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageNo=" + pageNo +
                ", pageTotal=" + pageTotal +
                ", pageSize=" + pageSize +
                ", recordCount=" + recordCount +
                ", items=" + items +
                '}';
    }

    public long getPageNo() {
        return pageNo;
    }

    public void setPageNo(long pageNo) {
        this.pageNo = pageNo;
    }

    public long getPageTotal() {
        return pageTotal;
    }

    public void setPageTotal(long pageTotal) {
        this.pageTotal = pageTotal;
    }

    public long getPageSize() {
        return pageSize;
    }

    public void setPageSize(long pageSize) {
        this.pageSize = pageSize;
    }

    public long getRecordCount() {
        return recordCount;
    }

    public void setRecordCount(long recordCount) {
        this.recordCount = recordCount;
    }

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }
}
