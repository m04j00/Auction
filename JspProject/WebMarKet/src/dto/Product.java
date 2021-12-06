package dto;

import java.io.Serializable;

public class Product implements Serializable {
	private static final long serialVersionUID = -4274700572038677000L;

	private String productId; // 占쏙옙품 占쏙옙占싱듸옙
	private String pname; // 占쏙옙품占쏙옙
	private Integer unitPrice; // 占쏙옙품占쏙옙占쏙옙
	private String description; // 占쏙옙품占쏙옙占쏙옙
	private String fileName; // �씠誘몄� �뙆�씪 紐�
	private int quantity;
	public Product() {
		super();
	}

	public Product(String productId, String pname, Integer unitPrice) {
		this.productId = productId;
		this.pname = pname;
		this.unitPrice = unitPrice;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
