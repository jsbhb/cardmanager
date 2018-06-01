package com.card.manager.factory.goods.pojo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.util.ParemeterConverUtil;
import com.card.manager.factory.util.Utils;

public class ImportGoodsBO {
	private String id;
	private String brandName;
	private String brandId;
	private String supplierName;
	private Integer supplierId;
	private String typeName;
	private Integer type;
	private String goodsName;
	private String firstCatalogName;
	private String firstCatalogId;
	private String secondCatalogName;
	private String secondCatalogId;
	private String thirdCatalogName;
	private String thirdCatalogId;
	private String incrementTax;
	private String tariff;
	private String unit;
	private String hscode;
	private String origin;
	private String itemCode;
	private String sku;
	private String encode;
	private String exciseFax;
	private String weight;
	private String conversion;
	private String proxyPrice;
	private String fxPrice;
	private String retailPrice;
	private String min;
	private String max;
	private String shelfLife;
	private String carTon;
	private String stock;
	private List<GoodsSpecsBO> specsList;
	private List<GoodsRebateBO> rebateList;

	public void init(Map<String, Integer> supplierMap, Map<String, Integer> gradeMapTemp,
			Map<String, String> firstMapTemp, Map<String, String> secondMapTemp, Map<String, String> thirdMapTemp,
			Map<String, String> brandMapTemp, Map<String, Integer> specsNameMap,
			Map<Integer, Map<String, Integer>> specsValueMap) {
		brandId = brandMapTemp.get(Utils.removePoint(brandName));
		firstCatalogId = firstMapTemp.get(Utils.removePoint(firstCatalogName));
		secondCatalogId = secondMapTemp.get(Utils.removePoint(secondCatalogName));
		thirdCatalogId = thirdMapTemp.get(Utils.removePoint(thirdCatalogName));
		supplierId = supplierMap.get(Utils.removePoint(supplierName));
		incrementTax = incrementTax == null || "".equals(incrementTax) ? "0.16" : incrementTax;
		tariff = tariff == null || "".equals(tariff) ? "0" : tariff;
		exciseFax = exciseFax == null || "".equals(exciseFax) ? "0" : exciseFax;
		type = ParemeterConverUtil.getOrderFlag(Utils.removePoint(typeName));
		if (rebateList != null) {
			GoodsRebateBO model = null;
			Iterator<GoodsRebateBO> it = rebateList.iterator();
			while (it.hasNext()) {
				model = it.next();
				if (!model.hasValue()) {
					it.remove();
					continue;
				}
				model.init(gradeMapTemp);
			}
			if(rebateList.size() == 0){
				rebateList = null;
			}
		}
		
		if (specsList != null) {
			GoodsSpecsBO model = null;
			Iterator<GoodsSpecsBO> it = specsList.iterator();
			while (it.hasNext()) {
				model = it.next();
				if (!model.hasValue()) {
					it.remove();
					continue;
				}
				model.init(specsNameMap, specsValueMap);
			}
			if(specsList.size() == 0){
				specsList = null;
			}
		}

	}

	// 多规格的时候不需要检查为空的字段
	public List<String> getSpecsUnCheckFieldName() {
		List<String> list = new ArrayList<String>();
		list.add("encode");
		list.add("exciseFax");
		list.add("hscode");
		list.add("shelfLife");
		list.add("carTon");
		list.add("tariff");
		list.add("incrementTax");
		list.add("specsList");
		list.add("rebateList");
		list.add("brandName");
		list.add("brandId");
		list.add("supplierName");
		list.add("supplierId");
		list.add("firstCatalogId");
		list.add("firstCatalogName");
		list.add("secondCatalogName");
		list.add("thirdCatalogName");
		list.add("thirdCatalogId");
		list.add("secondCatalogId");
		list.add("typeName");
		list.add("type");
		list.add("unit");
		list.add("origin");
		list.add("goodsName");
		return list;
	}

	// 不需要检查是否为空的字段
	public List<String> getBaseUnCheckFieldName() {
		List<String> list = new ArrayList<String>();
		list.add("encode");
		list.add("exciseFax");
		list.add("hscode");
		list.add("shelfLife");
		list.add("carTon");
		list.add("tariff");
		list.add("incrementTax");
		list.add("specsList");
		list.add("rebateList");
		return list;
	}

	public String getId() {
		return id;
	}

	public String getBrandId() {
		return brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getFirstCatalogId() {
		return firstCatalogId;
	}

	public void setFirstCatalogId(String firstCatalogId) {
		this.firstCatalogId = firstCatalogId;
	}

	public String getSecondCatalogId() {
		return secondCatalogId;
	}

	public void setSecondCatalogId(String secondCatalogId) {
		this.secondCatalogId = secondCatalogId;
	}

	public String getThirdCatalogId() {
		return thirdCatalogId;
	}

	public void setThirdCatalogId(String thirdCatalogId) {
		this.thirdCatalogId = thirdCatalogId;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getFirstCatalogName() {
		return firstCatalogName;
	}

	public void setFirstCatalogName(String firstCatalogName) {
		this.firstCatalogName = firstCatalogName;
	}

	public String getSecondCatalogName() {
		return secondCatalogName;
	}

	public void setSecondCatalogName(String secondCatalogName) {
		this.secondCatalogName = secondCatalogName;
	}

	public String getThirdCatalogName() {
		return thirdCatalogName;
	}

	public void setThirdCatalogName(String thirdCatalogName) {
		this.thirdCatalogName = thirdCatalogName;
	}

	public String getIncrementTax() {
		return incrementTax;
	}

	public void setIncrementTax(String incrementTax) {
		this.incrementTax = incrementTax;
	}

	public String getTariff() {
		return tariff;
	}

	public void setTariff(String tariff) {
		this.tariff = tariff;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getHscode() {
		return hscode;
	}

	public void setHscode(String hscode) {
		this.hscode = hscode;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String getExciseFax() {
		return exciseFax;
	}

	public void setExciseFax(String exciseFax) {
		this.exciseFax = exciseFax;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getConversion() {
		return conversion;
	}

	public void setConversion(String conversion) {
		this.conversion = conversion;
	}

	public String getProxyPrice() {
		return proxyPrice;
	}

	public void setProxyPrice(String proxyPrice) {
		this.proxyPrice = proxyPrice;
	}

	public String getFxPrice() {
		return fxPrice;
	}

	public void setFxPrice(String fxPrice) {
		this.fxPrice = fxPrice;
	}

	public String getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(String retailPrice) {
		this.retailPrice = retailPrice;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getMax() {
		return max;
	}

	public void setMax(String max) {
		this.max = max;
	}

	public String getShelfLife() {
		return shelfLife;
	}

	public void setShelfLife(String shelfLife) {
		this.shelfLife = shelfLife;
	}

	public String getCarTon() {
		return carTon;
	}

	public void setCarTon(String carTon) {
		this.carTon = carTon;
	}

	public String getStock() {
		return stock;
	}

	public void setStock(String stock) {
		this.stock = stock;
	}

	public List<GoodsSpecsBO> getSpecsList() {
		return specsList;
	}

	public void setSpecsList(List<GoodsSpecsBO> specsList) {
		this.specsList = specsList;
	}

	public List<GoodsRebateBO> getRebateList() {
		return rebateList;
	}

	public void setRebateList(List<GoodsRebateBO> rebateList) {
		this.rebateList = rebateList;
	}

}
