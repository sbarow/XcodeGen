class Xcodegen < Formula
  desc "Tool that generates your Xcode project from a project spec"
  homepage "https://github.com/yonaskolb/XcodeGen"
  url "https://github.com/yonaskolb/XcodeGen/archive/1.4.0.tar.gz"
  sha256 "e359e62c5884fc301c7355ff127cd9d3a32315523a4f5feb3a3e2294707cbcd6"
  head "https://github.com/yonaskolb/XcodeGen.git"

  depends_on :xcode

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"xcodegen.yml").write <<-EOS.undent
      name: GeneratedProject
      targets:
        TestProject:
          type: application
          platform: iOS
          sources: TestProject
          settings:
            PRODUCT_BUNDLE_IDENTIFIER: com.test
            PRODUCT_NAME: TestProject
    EOS
    Dir.mkdir(File.join(testpath, "TestProject"))
    system("#{bin}/XcodeGen --spec #{File.join(testpath, "xcodegen.yml")}")
    system("xcodebuild --project #{File.join(testpath, "GeneratedProject.xcodeproj")}")
  end
end
