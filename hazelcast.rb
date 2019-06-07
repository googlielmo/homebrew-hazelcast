class Hazelcast < Formula
  desc "Hazelcast IMDG Command Line Tool"
  homepage "https://github.com/googlielmo/hazelcast-command-line"
  url "https://github.com/googlielmo/hazelcast-command-line/releases/download/v3.12.0/hazelcast-3.12.0.tar.gz"
  sha256 "5cf60826902287f3f1594510065da7ae96dc192ea56704ff86755982d4ffa558"

  bottle :unneeded

  depends_on "coreutils"
  depends_on :java => "1.8+"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/hazelcast"]
    prefix.install_metafiles
  end

  test do
    begin
      id = shell_output("#{bin}/hazelcast member start -J -Dhazelcast.http.healthcheck.enabled=true").strip
      assert_match /\w+_\w+/, id
      sleep 5
      output = shell_output("#{bin}/hazelcast member list #{id}")
      assert_match /#{id}\s+\d+\s+RUNNING/, output

      assert_match /Hazelcast::NodeState=ACTIVE/, shell_output("curl -s http://127.0.0.1:5701/hazelcast/health")

      output = shell_output("#{bin}/hazelcast member stop #{id}")
      assert_match /#{id} stopped/, output

      output = shell_output("#{bin}/hazelcast member remove #{id}")
      assert_match /#{id} removed/, output
    ensure
      quiet_system "pkill", "-9", "-f", "hazelcast"
    end
  end
end
