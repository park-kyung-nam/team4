package dev.mvc.product;

public class FileVO {
  /** preview 이미지 */
  private String thumb;
  /** 하나의 파일명 */
  private String file;
  /** 하나의 파일 사이즈 */
  private String size;

  public FileVO() {

  }

  public FileVO(String thumb, String file, String size) {
    super();
    this.thumb = thumb;
    this.file = file;
    this.size = size;
  }

  /**
   * @return the thumb
   */
  public String getThumb() {
    return thumb;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  /**
   * @return the file
   */
  public String getFile() {
    return file;
  }

  /**
   * @param file the file to set
   */
  public void setFile(String file) {
    this.file = file;
  }

  /**
   * @return the size
   */
  public String getSize() {
    return size;
  }

  /**
   * @param size the size to set
   */
  public void setSize(String size) {
    this.size = size;
  }
  
}


